```
window.addEventListener("load", function(event) {
const elementToObserve = document.querySelector("#tempo-container");

if(elementToObserve){

const observer = new MutationObserver(function callback(mutationList, observer) {
  mutationList.forEach( (mutation) => {
    switch(mutation.type) {
      case 'childList':

for(var node of mutation.addedNodes.values()) {
  var attr = node.attributes.getNamedItem('data-testid');
  if(attr && attr.value === "toolbar"){	  
	  var rightSection = node.querySelector("[data-testid='right-section']");
	  
	  var div = document.createElement("div");
	div.id = "calculate-remaining-time-button";

	var button = document.createElement("button");
	var textnode = document.createTextNode("Calculate remaining time");

	button.classList.add("hDisto");
	button.style.lineHeight = "32px";

	div.appendChild(button);
	button.appendChild(textnode);
	button.addEventListener("click", event => {
		function calculateRemainder(timeString){
			var timeRange = timeString.split(" of ");
			var from = parseTime(timeRange[0]);
			var to = parseTime(timeRange[1]);
			return minsToStr(parseTime(timeRange[1]) - parseTime(timeRange[0]));
		}
		
		function minsToStr(minutes) { 
			var hours = Math.floor(minutes / 60);
			var mins = minutes % 60;
			return "-" + hours + "h " + mins +"m";
		}
		
		function parseTime(timeStr){
			var parts = timeStr.split(" ");

			if(parts.length === 1){
				var nr = parseInt(parts[0].replace("\w+", ""));

				if(parts[0].includes("h")){
					return nr * 60;
				}

				return nr;
			}
			return parseNumber(parts[0])*60 + parseNumber(parts[1]);  
		}
		
		var list = document.querySelectorAll("[data-testid='headerContent']");
		for (let item of list) {
			var timeDiv = item.children[0].children[1];
			var timeStr = timeDiv.textContent;
			timeDiv.textContent = calculateRemainder(timeStr);
		}
	});

	rightSection.prepend(div)
	  
	  observer.disconnect()
	  return;
  }
}
        break;
    }
  });
});

observer.observe(elementToObserve, {subtree: true, childList: true});
}
});

```

```
var x = document.querySelectorAll("[data-testid='issue.views.issue-details.issue-layout.left-most-column']")[0]
if(x){

var container = x.childNodes[3];

var buttonId = document.getElementById("copy-issue-summary-button");

if(!buttonId && container){
    var div = document.createElement("div");
    div.id = "copy-issue-summary-button";
    var button = document.createElement("button");
    var textnode = document.createTextNode("Copy issue summary");

    div.appendChild(button);
    button.appendChild(textnode);
    button.style.marginLeft = "8px";
    button.classList.add("css-1xewsy6");

    container.appendChild(div);
    var key = window.location.pathname.split("/");
    var issue = x.childNodes[1].querySelector("[data-testid='issue.views.issue-base.foundation.summary.heading']").textContent;
    button.addEventListener("click", ()=>copyTextToClipboard(key[2] + " " + issue));

var tempoButton = container.childNodes[3].childNodes[0];
tempoButton.remove();

}


function copyTextToClipboard(text) {
    window.prompt("Copy to clipboard: Ctrl+C, Enter", text);
}
}
```
