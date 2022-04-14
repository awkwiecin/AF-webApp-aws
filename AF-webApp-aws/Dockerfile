FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ./AF-webApp-aws/*.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY ./AF-webApp-aws/*.cs ./
COPY ./AF-webApp-aws/Controllers ./
COPY ./AF-webApp-aws/Model ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "AF-webApp-aws.dll"]
EXPOSE 80