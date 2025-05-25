import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="word-counter"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element)
    this.countTweetChars()
  }
  
  countTweetChars(){
    console.log("Hello, Stimulus!", this.element)

    let content = this.element.value.trim()
    let charCount = content.length
    if (content.includes("https://")){
      let url = content.match(/https:\/\/\S*/)[0]
      charCount = charCount - url.length + 23 
    }
    document.getElementById("char-count").innerHTML = charCount + " characters"
  }
  
}
