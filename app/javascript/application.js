// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import s from "toastr"

document.addEventListener("DOMContentLoaded", () => {
  toastr.options = {
    closeButton: true,
    progressBar: true,
    positionClass: "toast-bottom-right",
    timeOut: "3000",
  };

  // fire event to let know the other scripts when to launch toasts
  document.dispatchEvent(new Event("ReadyForToast"));
});

window.toastr = s;



