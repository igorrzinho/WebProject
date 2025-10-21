FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /source

COPY *.sln .
COPY SalesWebMvc/*.csproj ./SalesWebMvc/
RUN dotnet restore

COPY SalesWebMvc/.  ./SalesWebMvc/
WORKDIR /source/SalesWebMvc
RUN dotnet publish -c realese -o /app --no-restore

FROM mcr.microsoft.com/dotnet/sdk:8.0
WORKDIR /app
COPY --from=build /app ./
ENV ASPNETCORE_URLS=http://+:5205
EXPOSE 5205
ENTRYPOINT  ["dotnet", "SalesWebMvc.dll"]