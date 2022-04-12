﻿FROM docker.io/zlzforever/dotnet-yarn as build
WORKDIR /app
COPY src/SecurityTokenService ./
RUN yarn install && ls
RUN dotnet build SecurityTokenService.csproj -c Release -o /app/build

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app
COPY --from=build /app/build .
RUN rm -rf /app/wwwroot/css/site.css
RUN rm -rf /app/wwwroot/js/site.js
RUN rm -rf /app/sts.json
ENTRYPOINT ["dotnet", "SecurityTokenService.dll"]
EXPOSE 80
EXPOSE 443
