 /*
 	image file 확인
 */
 function checkImageType(fileName){
 	return fileName.indexOf("s_") > 0 ? true : false; 
 }
 
 function getFileInfo(fullName){
 	// 이미지 경로  원본파일 이름    원본파일 요청 경로
 	let imgSrc,   fileName,      getLink;
 	// a tag를 통해 파일 정보를 요청할 경로
 	if(checkImageType(fullName)){
 		// 이미지 파일
 		imgSrc = contextPath+"/displayFile?fileName="+fullName;
 		getLink = contextPath+"/displayFile?fileName="+fullName.replace("s_","");
 	}else{
 		// 일반 파일
 		imgSrc = contextPath+"/resources/images/img/file.png";
 		getLink = contextPath+"/displayFile?fileName="+fullName;
 	}
 	
 	fileName = fullName.substr(fullName.lastIndexOf("_")+1);
 	
 	return { fileName : fileName, imgSrc : imgSrc, getLink : getLink};
 }
 
function getThumbnailInfo(fullName){
 	if(checkImageType(fullName)){
 		imgSrc = contextPath+"/thumbnailFile?fileName="+fullName;
 		getLink = imgSrc;
	}
 	fileName = fullName.substr(fullName.lastIndexOf("_")+1);
 	return { fileName : fileName, imgSrc : imgSrc, getLink : getLink};
}