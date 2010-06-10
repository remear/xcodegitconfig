require 'fileutils'
require 'tempfile'

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text); colorize(text, 31); end
def green(text); colorize(text, 32); end
def cyan(text); colorize(text, 36); end
def yellow(text); colorize(text, 33); end

puts cyan("\nXcode Cocoa Application Git Settings Installer")
puts cyan("Created by Ben Mills. Unfiniti 2010\n")

user = %x{whoami}

if user.strip == "root"
  puts yellow("\nInstalling Xcode Project Git Settings\n")
  
  gitignoreFile = Tempfile.new('enc')
  gitignoreFile.puts <<-eos
.DS_Store
*.swp
*~.nib

build/

*.pbxuser
*.perspective
*.perspectivev3
          eos
  gitignoreFile.close
  
  gitattributesFile = Tempfile.new('enc')
  gitattributesFile.puts("*.pbxproj -crlf -diff -merge")
  gitattributesFile.close
  
  macOSXProjectBasePath = "/Developer/Library/Xcode/Project Templates/Application/Cocoa Application"
  macOSXProjectpaths = ["Cocoa Application", 
                        "Cocoa Document-based Application",
                        "Core Data Application",
                        "Core Data Application with Spotlight Importer",
                        "Core Data Document-based Application",
                        "Core Data Document-based Application with Spotlight Importer"]
                        
  puts green("   Writing configuration files to Mac OS Cocoa project templates...\n")
      
  macOSXProjectpaths.each do |path|
    FileUtils.copy(gitignoreFile.path, "#{macOSXProjectBasePath}/#{path}/.gitignore")
    FileUtils.copy(gitattributesFile.path, "#{macOSXProjectBasePath}/#{path}/.gitattributes")
  end
  
  # iPhone projects
  iPhoneProjectBasePath = "/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Project Templates/Application"
  iPhoneProjectPaths = ["Navigation-based Application/Navigation-based Application",
                        "Navigation-based Application/Navigation-based Core Data Application",
                        "OpenGL ES Application/OpenGL ES iPhone Application",
                        "Split View-based Application/Split View-based Application",
                        "Split View-based Application/Split View-based Core Data Application",
                        "Tab Bar Application/Tab Bar iPhone Application",
                        "Utility Application/Utility iPhone Application",
                        "Utility Application/Utility iPhone Core Data Application",
                        "View-based Application/View-based iPhone Application",
                        "Window-based Application/Window-based iPhone Application",
                        "Window-based Application/Window-based iPhone Core Data Application",
                        "Window-based Application/Window-based Universal Application",
                        "Window-based Application/Window-based Universal Core Data Application"]
                        
  puts green("   Writing configuration files to iPhone project templates...\n")
      
  iPhoneProjectPaths.each do |path|
    FileUtils.copy(gitignoreFile.path, "#{iPhoneProjectBasePath}/#{path}/.gitignore")
    FileUtils.copy(gitattributesFile.path, "#{iPhoneProjectBasePath}/#{path}/.gitattributes")
  end
  
  #iPad projects
  iPadProjectBasePath = "/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Project Templates/Application"
  iPadProjectPaths = ["OpenGL ES Application/OpenGL ES iPad Application",
                        "Tab Bar Application/Tab Bar iPad Application",
                        "View-based Application/View-based iPad Application",
                        "Window-based Application/Window-based iPad Application",
                        "Window-based Application/Window-based iPad Core Data Application"]
                        
  puts green("   Writing configuration files to iPad project templates...\n")
      
  iPadProjectPaths.each do |path|
    FileUtils.copy(gitignoreFile.path, "#{iPadProjectBasePath}/#{path}/.gitignore")
    FileUtils.copy(gitattributesFile.path, "#{iPadProjectBasePath}/#{path}/.gitattributes")
  end
  
  puts yellow("Git settings were sucessfully installed to Cocoa Application Xcode template\n")
else
  puts red("Insufficient privileges...")
  puts red("Please re-run this script as root.")
  exit
end
