# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
RUN ls -a

WORKDIR /source/Webdemo1
COPY Webdemo1 .
RUN ls -a

WORKDIR /source
RUN ls -a

RUN dotnet restore

# copy everything else and build app
RUN dotnet publish -c release -o /app --no-restore

RUN ls -a /app

## final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .


EXPOSE 8080
ENTRYPOINT ["dotnet", "Webdemo1.dll"]