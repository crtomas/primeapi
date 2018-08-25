# Build stage
FROM microsoft/dotnet:2.1-sdk AS build-env

WORKDIR /primeapi

#restore
COPY api/primeapi.csproj ./api/
RUN dotnet restore api/primeapi.csproj

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

#RUN ls -alR

#copy src
COPY . .

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