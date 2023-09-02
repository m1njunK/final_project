function appendMyText(text) {
	const textBox = document.querySelector("#chatBotText");
	let pTag = document.createElement("p");
	pTag.setAttribute("class","myChat");
	pTag.innerText = text;
	textBox.appendChild(pTag);
	scrollToBottom(textBox);
};

function appendText(textArray) {
	const textBox = document.querySelector("#chatBotText");
	textArray.forEach(text => {
		let pTag = document.createElement("p");
		pTag.setAttribute("class","aiChat");
		pTag.innerText = text;
		textBox.appendChild(pTag);
		scrollToBottom(textBox);
	});
	
	setTimeout(() => {
        const chatPromptInput = document.querySelector("#chatPrompt");
        chatPromptInput.disabled = false;
        chatPromptInput.focus();
    }, 0);
}

function scrollToBottom(div) {
    div.scrollTo(0, div.scrollHeight);
}

function generateText(prompt){
	generateText(prompt,0.7,50);
};

function generateText(prompt, temperature, maxTokens) {
	    const headers = {
	    	"Content-Type": "application/json",
	    	"Authorization": "Bearer " + apiKey
	    };

	    const requestBody = {
	        model: "gpt-3.5-turbo",
	        
	        messages: [
	          { role: "user", content: prompt +" 한글로 대답 "  },
	          { role: "system", content: "You are a game master."}
	        ],
	        
	        temperature: temperature,
	        
	        max_tokens: maxTokens
	      };

	      fetch(ENDPOINT, {
	        method: "POST",
	        headers: headers,
	        body: JSON.stringify(requestBody)
	      })
	      .then(response => response.json())
	      .then(data => {
	        const generatedText = data.choices[0].message.content; // 전체 답변받은내용
	        const textArray = generatedText.split('\n'); // 답변 받은걸 줄바뀜 기준으로 자른 배열
			appendText(textArray);
	      })
	      .catch(error => {
	        // 오류 처리
	        console.error("API 요청이 실패하였습니다:", error);
	        return null;
	      });
}