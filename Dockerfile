# Build stage
FROM microsoft/dotnet:2.1-sdk AS build-env

#SonarQube setup
RUN apt-get update && apt-get install -y openjdk-8-jre
RUN dotnet tool install --global dotnet-sonarscanner --version 4.3.1
COPY SonarQube.Analysis.xml /root/.dotnet/tools/.store/dotnet-sonarscanner/4.3.1/dotnet-sonarscanner/4.3.1/tools/netcoreapp2.1/any/SonarQube.Analysis.xml
ENV PATH="/root/.dotnet/tools:${PATH}"


WORKDIR /primeapi

#restore
COPY api/primeapi.csproj ./api/
RUN dotnet restore api/primeapi.csproj

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

#RUN ls -alR

#copy src
COPY . .

#SonatQube Scan
RUN dotnet sonarscanner begin /k:project-key
RUN dotnet build
RUN dotnet sonarscanner end

#test
ENV TEAMCITY_PROJECT_NAME=fake
RUN dotnet test tests/tests.csproj

#publish
RUN dotnet publish api/primeapi.csproj -o /publish

# Runtime stage
FROM microsoft/dotnet:2.1-aspnetcore-runtime
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT ["dotnet","primeapi.dll"]

#http://192.168.99.100:8080/api/primes
#http://192.168.99.100:8080/api/primes/5