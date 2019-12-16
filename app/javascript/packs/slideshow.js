export class Slideshow {
  constructor(selectors) {
    this.slideContainer = $(selectors.slideContainerId);
    this.slidesSrc = this.slideContainer.data(selectors.dataAttr).split(" ");
    this.slidesLength = this.slidesSrc.length + 1;
    this.currentSlide = 1;
    this.slideChangeTime = selectors.slideChangeTime;
  }

  getImages = () => {
    this.image_collection = this.slidesSrc.map( (image_src) => {
      var image = $('<img>').attr('src', image_src).fadeOut();
      this.slideContainer.append(image);
      return image;
    });
  }

  startShow = () => {
    var currentImage = this.image_collection[this.currentSlide - 1]
    currentImage.fadeIn('slow');
      currentImage = this.image_collection[this.currentSlide - 1];
      currentImage.fadeOut('slow');
      this.currentSlide++;
      if (this.currentSlide === this.slidesLength) {
        this.currentSlide = 1;
      }
    setTimeout(this.startShow, this.slideChangeTime);
  }

  init = () => {
    this.getImages();
    this.startShow();
  }
}
