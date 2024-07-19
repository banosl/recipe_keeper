import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Recipe controller connected")
  }
  delete(event) {
    let confirmed = confirm("Are you sure?")

    if(!confirmed) {
      event.preventDefault()
    }
  }
}