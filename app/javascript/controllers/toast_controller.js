import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast"
export default class extends Controller {
    static values = {
        timeout: {type: Number, default: 100000} // Define a value for the timeout duration in milliseconds
    }

    connect() {
        console.log("Toast connected");
        // Automatically remove the flash message after the specified timeout
        if (this.hasTimeoutValue) {
            setTimeout(() => {
                this.close();
            }, this.timeoutValue);
        }
    }

    close() {
        // Remove the flash message element from the DOM
        this.element.remove();
    }
}