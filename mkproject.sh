#!/bin/bash
# mkproject.sh xyz [-python -python3 -go]

projectname=$1
projectroot="${HOME}/Beeva/${projectname}"


mkdir -p "${projectroot}/bin"

echo 'export PROJECTROOT=$(expand_path .)' > "${projectroot}/.envrc"
echo 'export PATH=$(expand_path bin):$PATH' >> "${projectroot}/.envrc"

shift
for opt in "$@"
do
    case $opt in
        "-python")
            echo 'layout python' >> "${projectroot}/.envrc"
            ;;
        "-python3")
            echo 'layout python3' >> "${projectroot}/.envrc"
            ;;
        "-go")
            mkdir -p "${projectroot}/go"
            echo 'export GOPATH=$(expand_path go)' >> "${projectroot}/.envrc"
            echo 'export PATH=$(expand_path go/bin):$PATH' >> "${projectroot}/.envrc"
            ;;
        "-node")
            echo 'layout_node' >> "${projectroot}/.envrc"
            ;;
        *)
            echo "${opt}?"
            ;;
    esac
done

