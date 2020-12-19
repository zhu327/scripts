addEventListener(
  "fetch", event => {
    let url = new URL(event.request.url);
    url.host = "v2ray_host";
    let request = new Request(url, event.request);
    event.respondWith(
      fetch(request)
    )
  }
)