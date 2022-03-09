nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-k> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "vimux"
let test#python#runner = 'pytest'
let g:test#echo_command = 0
let g:test#preserve_screen = 1


function! MetaflowDockerTransform(cmd)
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
                        \}
    let l:project = split(split(a:cmd, " ")[-1], "/tests")[0]

    let l:default_project_details = {
                    \"docker_compose_file": "docker-compose.yml",
                    \"service_name": l:project . "-dev",
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
endfunction

let g:test#custom_transformations = {'docker': function('MetaflowDockerTransform')}
let g:test#transformation = 'docker'
