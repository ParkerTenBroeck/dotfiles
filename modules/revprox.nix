{
  services.caddy = {
    enable = true;

    virtualHosts."git.spcf.me".extraConfig = ''
      reverse_proxy 127.0.0.1:3000
    '';
    virtualHosts."meow.spcf.me".extraConfig = ''
      templates
      
      respond <<EOF
      IP: {http.request.header.CF-Connecting-IP}
      Country: {http.request.header.CF-IPCountry}
      City: {http.request.header.CF-IPCity}
      Region: {http.request.header.CF-Region}
      Region Code: {http.request.header.CF-Region-Code}
      Postal Code: {http.request.header.CF-Postal-Code} 
      {{- if .Req.Header.Get "X-CF-Latitude" }}
        Latitude: {{ .Req.Header.Get "X-CF-Latitude" }}
      {{- end }}
      {{- if .Req.Header.Get "X-CF-Longitude" }}
        Longitude: {{ .Req.Header.Get "X-CF-Longitude" }}
      {{- end }}
      {{- if .Req.Header.Get "X-CF-Continent" }}
        Continent: {{ .Req.Header.Get "X-CF-Continent" }}
      {{- end }}

      Ray: {http.request.header.CF-Ray}
      Visitor: {http.request.header.CF-Visitor}
      Connecting IP: {http.request.header.CF-Connecting-IP}
      X-Forwarded-For: {http.request.header.X-Forwarded-For}
      X-Forwarded-Proto: {http.request.header.X-Forwarded-Proto}
      Host: {http.request.host}
      User Agent: {http.request.header.User-Agent}
     EOF
    '';
  };
}
