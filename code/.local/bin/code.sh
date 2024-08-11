#! /bin/bash
                                                                             
#contributed by @Lazy Ren at StackOverflow
#See https://stackoverflow.com/questions/62201080/is-it-possible-to-use-the-code-command-in-sshed-terminal-to-open-vs-code-on-l

max_retry=10                                                                 
                                                                             
for i in $(seq 1 $max_retry); do
    recent_folder=$(ls -d ~/.vscode-server/cli/servers/*/ -t | head -n1 | tail -1)                                                             
    script=$(echo $recent_folder/server/bin/remote-cli/code)   
    if [[ -z ${script} ]]                                                    
    then                                                                     
        echo "VSCode remote script not found"                                
        exit 1                                                               
    fi                                                                       
    socket=$(ls /run/user/$UID/vscode-ipc-* -t | head -n$i | tail -1)        
    if [[ -z ${socket} ]]                                                    
    then                                                                     
        echo "VSCode IPC socket not found"                                   
        exit 1                                                               
    fi                                                                       
    export VSCODE_IPC_HOOK_CLI=${socket}                                     
    ${script} $@ 2>/dev/null                                                             
    if [ "$?" -eq "0" ]; then                                                
        exit 0                                                               
    fi                                                                       
done                                                                         
                                                                             
echo "Failed to find valid VS Code window"
