#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["DockerExApi_Angular.csproj", ""]
RUN dotnet restore "DockerExApi_Angular.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "DockerExApi_Angular.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DockerExApi_Angular.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DockerExApi_Angular.dll"]