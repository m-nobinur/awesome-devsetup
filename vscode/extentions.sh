#!/bin/bash

# Go to https://marketplace.visualstudio.com/ and search for the extention you want to install.
# Go to the extention's page press cmd+f and search for "unique identifier" and copy the identifier.
# Paste the identifier below on a new line.
#
# If you don't need a extention just comment it out.

export extentions=(
            zhuangtongfa.Material-theme                # one-dark-pro theme
            PKief.material-icon-theme                  # Material Design icons
            ms-python.python                           # extention for python support
            ms-python.vscode-pylance                   # Fast, feature-rich language support for Python
            njpwerner.autodocstring                    # Python Docstring Generator
            ms-vscode.cpptools                         # extention for c++ support
            yzhang.markdown-all-in-one                 # Markdown Support for Visual Studio Code
            ritwickdey.LiveServer                      # Local development server with live reload
            VisualStudioExptTeam.vscodeintellicode     # AI-assisted IntelliSense features for Python, TypeScript/JavaScript
            eamodio.gitlens                            # GitLens supercharges the Git capabilities built into Visual Studio Code
            donjayamanne.githistory                    # View git log, file history, compare branches or commits
            formulahendry.code-runner                  # Run C, C++, Java, JS, PHP, Python, Perl, Ruby, Go, Lua, Groovy, PowerShell and many more
            ecmel.vscode-html-css                      # CSS Intellisense for HTML
        	formulahendry.auto-rename-tag              # auto rename html tag
            formulahendry.auto-close-tag               # auto close html tag
            christian-kohler.path-intellisense         # Relative path intellisense
            naumovs.color-highlight                    # css, html color highlighter
            esbenp.prettier-vscode                     # code formatter for JS, TS, HTML, Json, CSS and more.
            alefragnani.Bookmarks                      # Bookmarks any line and jump to them
            batisteo.vscode-django                     # VsCode Django support
            bibhasdn.django-html	                   #  Django template support and intellisense.
            cstrap.flask-snippets                      # Snippets support for Flask
            dsznajder.es7-react-js-snippets            # React and modern js snippets.
            CoenraadS.bracket-pair-colorizer-2         # extension for colorizing matching brackets
            inu1255.easy-snippet                       # Create snippet without any pain for any language.
            Gruntfuggly.todo-tree                      # Extract todos from your code.

            # MS-vsliveshare.vsliveshare
            # ms-azuretools.vscode-docker	
            # wayou.vscode-todo-highlight	
            # msjsdiag.debugger-for-chrome
            # Zignd.html-css-class-completion
            # xabikos.JavaScriptSnippets	
            # DavidAnson.vscode-markdownlint
            # GrapeCity.gc-excelviewer
            # wayou.vscode-todo-highlight
            # christian-kohler.npm-intellisense
            # thekalinga.bootstrap4-vscode	
            # alefragnani.project-manager
            # mhutchie.git-graph
            # felipecaputo.git-project-manager
            # oderwat.indent-rainbow

            # GitHub.github-vscode-theme
            # dracula-theme.theme-dracula
            # zhuangtongfa.Material-theme	
        )