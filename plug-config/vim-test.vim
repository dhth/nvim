nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-t> :TestNearest<CR>:silent !tmux select-pane -t .+1 && tmux resize-pane -Z<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-l> :TestSuite<CR>
" nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "vimux"
let test#python#runner = 'pytest'
let g:test#echo_command = 0
let g:test#preserve_screen = 1


function! MetaflowDockerTransform(cmd)
    let l:file_type = &filetype

    if l:file_type == "python"
        let l:project_mapping = {
                    \"projects/project_a": {
                        \"docker_compose_file": "docker-compose-project-a.yml",
                        \"service_name": "project-a-dev",
                        \},
                    \"projects/metasync": {
                        \"docker_compose_file": "docker-compose-metasync-test-local.yml",
                        \"service_name": "metasync-test",
                        \},
                    \"projects/lib": {
                        \"docker_compose_file": "docker-compose-metasync-run.yml",
                        \"service_name": "metasync-dev",
                        \},
                        \"projects/api": {
                            \"docker_compose_file": "docker-compose-metaflow-api-test-local.yml",
                            \"service_name": "metaflow-api-test",
                            \},
                        \"app": {
                            \"docker_compose_file": "docker-compose-test.yml",
                            \"service_name": "img-anon-api-test",
                            \},
                        \"webapptests": {
                            \"docker_compose_file": "docker-compose.yml",
                            \"service_name": "webapptests-dev",
                            \},
                            \}
        let l:project = split(split(a:cmd, " ")[-1], "/tests")[0]

        let l:default_project_details = {
                        \"docker_compose_file": "docker-compose-test.yml",
                        \"service_name": l:project . "-test",
                        \}

        let l:project_details = get(l:project_mapping, l:project, l:default_project_details)

        let l:docker_compose_file = l:project_details["docker_compose_file"]
        let l:service_name = l:project_details["service_name"]

        let l:stripped_cmd = substitute(a:cmd, ".*/tests", "tests", "")

        if l:project ==# "projects/lib"
            let l:stripped_cmd = substitute(l:stripped_cmd, "tests", "tests/lib", "")
        endif

        " long traceback if running a single test
        if a:cmd =~ ".py.*"
            let l:traceback_format = "long"
        else
            let l:traceback_format = "short"
        endif

        let l:docker_cmd = "docker-compose -f " . l:docker_compose_file . " exec " . l:service_name . " bash -c \"TESTING=1 python -m pytest -v -s --tb=" . l:traceback_format . " " . l:stripped_cmd."\""
        " only store test results if a whole file is run
        if a:cmd =~ ".py$"
            let l:docker_cmd = l:docker_cmd .. ' | tee testsfailedall'
            execute 'silent !echo "' .. l:project .. '" > testlastproject'
        endif

        return l:docker_cmd
    elseif l:file_type == "scala"
        " need to convert a command like
        " sbt "testOnly *ApplicationServiceSpec"
        " to
        " testOnly *ApplicationServiceSpec
        " or 
        " sbt "testOnly *ApplicationServiceSpec -- -z \"create a new Application\""
        " to
        " testOnly *ApplicationServiceSpec -- -z \"create a new Application\"
        let l:command_els = split(a:cmd, " ")
        let l:command_els_needed = join(l:command_els[1:])
        let l:command_els_needed_stripped = l:command_els_needed[1:-2]
        return l:command_els_needed_stripped
    else
        return a:cmd
endfunction

let g:test#custom_transformations = {'docker': function('MetaflowDockerTransform')}
let g:test#transformation = 'docker'
