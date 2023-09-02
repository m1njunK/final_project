package com.bitc.project.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bitc.project.util.FileUtils;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class FileController {
	
	private final ServletContext context;
	
	private final String uploadPath;
	
	private String realPath;
	private String boardPath; 
	
	@PostConstruct
	public void initPath() {
		realPath = context.getRealPath(File.separator+uploadPath);
		boardPath = context.getRealPath(File.separator+"resources"+File.separator+"imgBank");
		File file = new File(realPath);
		File file2 = new File(boardPath);
		if(!file.exists()) {
			file.mkdirs();
		}
		if(!file2.exists()) {
			file2.mkdirs();
		}
	}
	
	@PostMapping("/uploadFile")
	public ResponseEntity<Object> uploadFile(
				MultipartFile[] file
			){
		ResponseEntity<Object> entity = null;
		try {
			List<String> list = new ArrayList<>();
			for(MultipartFile f : file) {
				String savedName = FileUtils.uploadFile(realPath, f);
				list.add(savedName);
			}
			entity = new ResponseEntity<>(list,HttpStatus.CREATED);
		} catch (Exception e) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<>(e.getMessage(),headers,HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@PostMapping("/boardUpload")
	public ResponseEntity<Object> boardUpload(MultipartFile[] file){
		ResponseEntity<Object> entity = null;
		try {
			Map<String, String> map = new HashMap<>();
			for(MultipartFile f : file) {
				String savedName = FileUtils.thumbnailFile(boardPath, f);
				map.put("location","/project/resources/imgBank"+savedName);
			}
			entity = new ResponseEntity<>(map,HttpStatus.CREATED);
		} catch (Exception e) {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<>(null,headers,HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName)throws Exception{
		return new ResponseEntity<>(
					FileUtils.getBytes(realPath, fileName),
					FileUtils.getHeaders(fileName),
					HttpStatus.CREATED);
	}

	@GetMapping("/thumbnailFile")
	public ResponseEntity<byte[]> thumbnailFile(String fileName)throws Exception{
		return new ResponseEntity<>(
				FileUtils.getBytes(boardPath, fileName),
				FileUtils.getHeaders(fileName),
				HttpStatus.CREATED);
	}
	
	// 파일 삭제
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName) throws Exception{
		boolean isDeleted = FileUtils.deleteFile(realPath, fileName);
		return new ResponseEntity<>(isDeleted ? "SUCCESS" : "FAILED", HttpStatus.OK);
	}
	
	// 파일 삭제
	@PostMapping("/deleteThumbnail")
	public ResponseEntity<String> deleteThumbnail(String fileName) throws Exception{
		boolean isDeleted = FileUtils.deleteFile(boardPath, fileName);
		return new ResponseEntity<>(isDeleted ? "SUCCESS" : "FAILED", HttpStatus.OK);
	}
	
	// 첨부된 게시글의 첨부 파일 모두 삭제
	@PostMapping("/deleteAllFiles")
	public ResponseEntity<String> deleteAllFiles(
			 // List<String> files       List interface 생성 불가
			@RequestParam("files[]") String files[]
			) throws Exception{
		boolean isDeleted = false;
		for(String file : files) {
			isDeleted = FileUtils.deleteFile(realPath, file);
		}
		return new ResponseEntity<>(isDeleted ? "DELETED" : "FAILED" , HttpStatus.OK);
	}
}



















