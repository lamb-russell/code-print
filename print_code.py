import os

# Set the directory path to the current directory
directory = os.getcwd()

# Specify the directories to exclude
exclude_dirs = [
    "node_modules", "vendor", "packages", "lib", "dist", "build", "target", "bin", "obj",
    "tmp", "temp", "cache", ".cache", "__pycache__",
    "logs", "output", "out",
    ".vscode", ".idea", ".settings", ".project", ".classpath",
    ".git", ".svn", ".hg",
    "docs", "doc", "examples", "samples"
]

# Specify the files to exclude
exclude_files = [
    ".DS_Store", "Thumbs.db", "desktop.ini",
    "*~", "*.bak", "*.tmp", "*.temp", "*.swp",
    "*.pyc", "*.class", "*.exe", "*.dll", "*.so", "*.o",
    "package-lock.json", "yarn.lock", "composer.lock", "Gemfile.lock"
]

# Specify the file extensions to exclude
exclude_extensions = [
    ".ico", ".png", ".jpg", ".jpeg", ".gif", ".bmp", ".svg",
    ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx",
    ".zip", ".tar", ".gz", ".rar", ".7z",
    ".mp3", ".wav", ".mp4", ".avi", ".mov"
]

# Traverse the directory and its subdirectories
for root, dirs, files in os.walk(directory):
    # Exclude specified directories
    dirs[:] = [d for d in dirs if d not in exclude_dirs]
    
    for file in files:
        file_path = os.path.join(root, file)
        
        # Check if the file should be excluded based on the file name
        if any(exclude_file in file for exclude_file in exclude_files):
            continue
        
        # Check if the file should be excluded based on the file extension
        _, extension = os.path.splitext(file)
        if extension.lower() in exclude_extensions:
            continue
        
        # Print the full file path
        print(f"File: {file_path}")
        print()
        
        # Print the code content of the file
        try:
            with open(file_path, "r") as f:
                code_content = f.read()
                print(code_content)
                print()
                print("------------------------")
                print()
        except UnicodeDecodeError:
            print("Skipping binary file.")
            print()
            print("------------------------")
            print()


