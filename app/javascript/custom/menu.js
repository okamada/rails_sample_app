// メニュー操作

// Toggle Listenerを追加してClickをListenする。
document.addEventListener("turbo:load", function() {
  let account = document.querySelector("#account");
  account.addEventListener("click", function(event) {
    event.preventDefault();
    let menu = document.querySelector("#dropdown-menu");
    menu.classList.toggle("active");
  });
});
