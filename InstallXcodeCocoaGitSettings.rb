def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text); colorize(text, 31); end
def green(text); colorize(text, 32); end

puts green("\nInstalling Xcode Git Settings\n")

user = %x{whoami}

if user.strip == "root"
  #write .gitignore file
  File.open("/Developer/Library/Xcode/Project Templates/Application/Cocoa Application/Cocoa Application/.gitignore", 'w') do |f|
    
    f.write <<-eos
.DS_Store
*.swp
*~.nib

build/

*.pbxuser
*.perspective
*.perspectivev3
            eos
  end
  
  #write .gitattributes file
  File.open("/Developer/Library/Xcode/Project Templates/Application/Cocoa Application/Cocoa Application/.gitattributes", 'w') do |f|
    f.write("*.pbxproj -crlf -diff -merge")
  end
  
  puts green("Git settings were sucessfully installed to Cocoa Application Xcode template")
else
  puts red("Insufficient privileges...")
  puts red("Please re-run this script as root.")
  exit
end
