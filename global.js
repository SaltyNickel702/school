window.addEventListener('load',() => {
    var imgs = document.getElementsByTagName('img');
	for (let i = 0; i < imgs.length; i++) {
		var img = imgs[i];
		if (!hasClass(img,'dragable')) {
			img.setAttribute('ondragstart','return false;');
		}
	}
})

function hasClass (el,name) {
	var cls = el.className.split(' ');
	for (let i = 0; i < cls.length; i++) {
		if (cls[i] === name) {
			return true
		}
	}
	return false;
}
function addClass (el,name) {
	if (hasClass(el,name)) {
		return;
	}
	el.className = `${el.className} ${name}`;
}
function removeClass (el,name) {
	var cls = el.className.split(' ')
	for (let i = 0; i < cls.length; i++) {
		if (cls[i] === name) {
			cls.splice(i,1);
			break;
		}
	}
	el.className = cls.join(' ');
}


//Animations
var anims = [];
function addAnimScroll (animationName, animationContents, animLength = 1000) {
	//create animation + class
	var anim = `@keyframes ${animationName} {${animationContents}}`
	var classCSS = `.${animationName}Anim {animation: ${animationName} ${animLength}ms;}`;
	var style = document.createElement('style')
	style.innerHTML = `${anim}\n${classCSS}`
	style.id = `${animationName}AnimStyle`
	document.head.appendChild(style);

	
	var docs = document.getElementsByClassName(animationName);
	for (let i = 0; i < docs.length; i++) {
		var p = docs[i];

		p.parentElement.style.overflowY = 'hidden'

		var bounds = p.getBoundingClientRect();
		var dat = {element:p,bounds,visible: false, animName:animationName, animLength, bnOff: false, timeout: undefined};
		anims.push(dat);
	}
}
window.addEventListener('scroll', () => {
	var visibility = window.scrollY + document.documentElement.clientHeight;
	anims.forEach((e,i,a) => {
		if (e.bounds.top <= visibility - 3) {
			if (!e.bnOff) {
				return;
			}
			//start animation
			if (!e.visible) { //is not already visible
				addClass(e.element,`${e.animName}Anim`);
				e.timeout = setTimeout(() => {
					removeClass(e.element,`${e.animName}Anim`);
				},e.animLength)
				e.visible = true;
			} else {
			}
		} else {
			if (e.visible) {
				clearTimeout(e.timeout);
				removeClass(e.element,`${e.animName}Anim`);
				e.visible = false;
			}

			e.bnOff = true; //element has been off screen

			
		}
	})
})