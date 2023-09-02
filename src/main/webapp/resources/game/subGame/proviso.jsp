<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/game/css/proviso.css" />
<section>
	<div id="provisoBox">
		<div id="provisoIntro">단서들을 사용해보자</div>
		<div id="itemUseFailed">이게 맞을까 ? 다시해보자</div>
		<div class="p_close" onclick="closeProviso();"></div>
		<div id="p_closeTrue">
            	이제 무언가 실마리가 보이는거같은데 돌아가자.
            <div id="p_end" onclick="provisoEnd();">돌아간다</div>
       	</div>
        <div id="p_closeFalse" onclick="closeProviso();">
            	아직 확인해야 할 단서들이 남은거같은데.. <br/> 다시 한번 확인해보자.
        </div>
		<div id="p_itemBox">
			<div id="p_item1" ondragover="handleDragOver(event)" ondrop="handleDrop(event, 'p_item1')">
				<img src="" alt="" id="p_item1_img" />
			</div>
			<div id="p_item2" ondragover="handleDragOver(event)" ondrop="handleDrop(event, 'p_item2')">
				<img src="" alt="" id="p_item2_img" />
			</div>
			<div id="keyAndBox" onclick='p_click("keyAndBox");'>
				상자를 열었더니 무슨 서류가 나왔다.
			</div>
			<div id="lampAndPaper" onclick='flashlightStart();'>
				램프로 종이를 비춰보니 무슨 글자들이 보인다.
			</div>
		</div>
		<div id="p_btnBox">
			<div id="useBtn" onclick="itemUse();">USE</div>
		</div>
	</div>
	<div id="flashLightBox">
		<div class="p_close" onclick="closeFlashlight();"></div>
		<div id="flashlight"></div>
		<div id="closeText_flash" class="closeText">
            다 읽었으면 돌아갈까 ... ? <br/>
            <div id="yes" onclick="flashLightEnd();">예</div>
            /
            <div id="no" onclick="closeFlashlight();">아니오</div>
        </div>
		<p id="p_emilyText">
			<br/><br/>
			사랑하는 모든 이에게,
			<br/><br/>
			이 편지를 보고 있는 당신들은 내가 지금 여기에 없다는걸 알고 있겠죠.
			<br/><br/>
			지금 내가 전하고자 하는 말은 나를 이해하는 사람들에게 전하고 싶은 말입니다.
            <br/><br/>
    		나는 보석 컬렉션 박물관의 관리자로서 오랜시간 박물관에서 시간을 보냈고, 보석이 사라졌을때 사건에 연루되었다는 느낌이 들었습니다.
            <br/><br/> 
    		나는 내 지위와 진귀한 보석들을 지키는 역할을 오래 해왔습니다.
            <br/><br/>
    		그러나 이번 사건은 나의 역할이 의미 없게 만들었습니다. 보석이 사라진 것은 전적으로 저의 책임입니다.
            <br/><br/>
            그에 따른 영향인지 저를 해고하겠다는 소문이 들리고 저는 많은 스트레스를 받았습니다.
            <br/><br/>
            그리고 그 소문이 사실이란걸 알게 된 순간, 저는 이 사건에 대해 엄청난 불안을 느꼈습니다. 
            <br/><br/>
            이 모든 것은 욕심과 자만에 뿌리를 두고 있었고, 이제 그 후회와 책임을 지기 위해 이 편지를 남깁니다.
            <br/><br/>
            이 사건으로 인해 저는 박물관의 소중한 유물을 훔치는 범죄자로까지 추락했습니다. 하지만 이 행동이 옳은 것은 아닙니다.
            <br/><br/>
            나는 이 편지를 통해 나의 행동에 대한 사과와 후회의 말을 전하고 싶습니다. 
            <br/><br/>
            이제는 모든 것이 이미 늦었지만, 적어도 솔직한 마음으로 사과하며 떠나고자 합니다.
		</p>
		<p id="p_fname">카렌 스미스</p>
	</div>
	
	<div id="p_letterBox">
			<div class="p_close" onclick="closeLetter();"></div>
			<div id="closeText_letter" class="closeText">
            	다 읽었으면 돌아갈까 ... ? <br/>
            	<div id="yes" onclick="letterEnd();">예</div>
            	/
            	<div id="no" onclick="closeLetter();">아니오</div>
        	</div>
        <p id="p_carenText">
        	<br/><br/>
        	에밀리에게, 당신이 지난 날 빛나는 별을 훔친 것을 압니다.
        	<br/><br/>
			에밀리, 너의 가족에 안전을 생각한다면, 빛나는 별을 어디에 숨겨놓았는지 밝혀야할겁니다.
        	<br/><br/>
         	이 보석은 그 자체로 큰 가치가 있지만, 그 이상의 비밀이 있습니다.
        	<br/><br/>
			그러나 만약 당신이 협력하지 않는다면, 가족들은 큰 위험에 빠질 것같군요.
        	<br/><br/>
			내가 당신에게 요구하는 것은 단순하지만, 당신의 미래와 가족의 안전을 위해서는 중요한 일입니다. 
        	<br/><br/>
        	너의 결정이 가족에게 어떤 영향을 끼칠지 상상해보십시오.
			<br/><br/>
			보석을 내게로 가져오지 않는다면, 네 가족은 위험에 처하게 될 것입니다.		
			<br/><br/>
			진지하게 너와 가족을 지키는 것이 내 목표라는 것을 잊지 마십시오.
			<br/><br/>
			계속해서 나를 의심하고 무시한다면, 이 일이 실제로 어떤 근원에서 비롯된 것인지 알아낼 것입니다.
			<br/><br/>
			너의 결정은 네 가족의 운명을 결정할 것입니다. 			
			<br/><br/>
			내게 보석을 가져오면 가족은 안전하게 보호될 것이며, 그렇지 않다면 그 결과를 직접 느끼게 될 것입니다.
			<br/><br/>
			조심스럽게 생각하십시오.
        </p>
		<p id="p_lname">누군가</p>
	</div>
	<div id="p_docBox">
			<div class="p_close" onclick="closeDoc();"></div>
			<div id="closeText_doc" class="closeText">
            	다 읽었으면 돌아갈까 ... ? <br/>
            	<div id="yes" onclick="docEnd();">예</div>
            	/
            	<div id="no" onclick="closeDoc();">아니오</div>
        	</div>
        <p id="p_docTextMain">        
        	NOTICE OF DISMISSAL
        </p>
        <p id="p_docText">
        	이 문서는 본 박물관에서 근무하고 있는 아래의 직원에게 해고 조치가 취해졌음을 통지합니다.
        	<br/><br/>
        	이름 : 카렌 스미스
        	<br/><br/>
        	직책 : 보안 담당자
        	<br/><br/>
        	해고 사유: 업무 수행 불성실, 조직 내 분쟁 조장
        	<br/><br/>
        	상기의 직원은 본 박물관의 목표와 가치에 부합하지 않는 행동을 했으며, <br/>
        	업무 수행 불성실 및 조직 내 분쟁을 조장하였음으로 인해 본 조치를 결정하게 되었습니다. <br/>
			위의 직원은 본 박물관 내의 모든 권한 및 재산 사용 권한을 박탈하며, 본 해고는 즉각적으로 시행됩니다.
        </p>
		<p id="p_docTextEnd">
			날짜 : July 18, 19xx
			<br/><br/>
			확인자 : 빅토르 위고	
		</p>
        <div id="fireImg"></div>
	</div>
</section>