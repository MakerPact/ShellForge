param (
    [string]$ProjectName
)

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create the project directory
New-Item -ItemType Directory -Name $ProjectName

# Change into the new directory
cd $ProjectName

# Create a src directory
New-Item -ItemType Directory -Name "src"

# Create a main.cpp file
@'
#include <iostream>

int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
'@ | Set-Content -Path "src/main.cpp"

# Create a Makefile
@'
CXX = g++
CXXFLAGS = -std=c++11 -Wall

SRCS = src/main.cpp
OBJS = $(SRCS:.cpp=.o)
EXEC = main

all: $(EXEC)

$(EXEC): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(EXEC) $(OBJS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(EXEC)
'@ | Set-Content -Path "Makefile"

# Initialize a new Git repository
git init

# Create a .gitignore file
@'
*.o
main
'@ | Set-Content -Path ".gitignore"

Write-Host "Successfully created a new C++ project: $ProjectName"
