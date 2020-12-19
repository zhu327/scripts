addEventListener(
  "fetch", event => {
    let url = new URL(event.request.url);
    url.host = "loads-editions-handed-relate.trycloudflare.com";
    let request = new Request(url, event.request);
    event.respondWith(
      fetch(request)
    )
  }
)
