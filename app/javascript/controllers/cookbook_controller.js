import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Cookbook controller connected")
  }
  delete(event) {
    let confirmed = confirm("Are you sure?")
    console.log("Confirmed", confirmed)

    if(!confirmed) {
      event.preventDefault()
    }
  }
}