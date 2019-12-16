import {Slideshow} from './slideshow.js';

function starter() {
  var selectors = {
    slideContainerId : '#slide_container',
    slideClass : '.product_images',
    dataAttr : 'images',
    slideChangeTime : 3000
  };

  var slideshow = new Slideshow(selectors);
  slideshow.init();
}

$(document).ready(starter);
