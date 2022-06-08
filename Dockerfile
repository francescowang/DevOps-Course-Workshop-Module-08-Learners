FROM mcr.microsoft.com/dotnet/sdk:6.0
USER root
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
COPY . /opt
WORKDIR /opt
RUN dotnet build
WORKDIR /opt/DotnetTemplate.Web
RUN npm install
RUN npm rebuild node-sass
RUN npm run build
WORKDIR /opt/
RUN dotnet test
WORKDIR /opt/DotnetTemplate.Web
RUN npm t
RUN npm run lint
EXPOSE 5000

# ENTRYPOINT ["tail", "-f", "/dev/null" ]
ENTRYPOINT ["dotnet", "run"]


