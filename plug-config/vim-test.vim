nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "vimux"
let test#python#runner = 'pytest'
let g:test#echo_command = 0


function! MetaflowDockerTransform(cmd)
    let l:project_mapping = {
                \"projects/metasync": {
                    \"docker_compose_file": "docker-compose-metasync-run.yml",
                    \"service_name": "metasync-dev",
                    \},
                \"projects/lib": {
                    \"docker_compose_file": "docker-compose-metasync-run.yml",
                    \"service_name": "metasync-dev",
                    \},
                    \"projects/api": {
                        \"docker_compose_file": "docker-compose-metaflow-api.yml",
                        \"service_name": "metaflow-api-dev",
                        \},
                        \}
    let l:project = split(split(a:cmd, " ")[1], "/tests")[0]

    let l:docker_compose_file = l:project_mapping[l:project]["docker_compose_file"]
    let l:service_name = l:project_mapping[l:project]["service_name"]
    let l:stripped_cmd = substitute(a:cmd, ".*/tests", "tests", "")

    if l:project ==# "projects/lib"
        let l:stripped_cmd = substitute(l:stripped_cmd, "tests", "tests/lib", "")
    endif

    let l:docker_cmd = "docker-compose -f " . l:docker_compose_file . " exec " . l:service_name . " bash -c \"TESTING=1 python -m pytest -qs ".l:stripped_cmd."\""
    return l:docker_cmd
endfunction

let g:test#custom_transformations = {'docker': function('MetaflowDockerTransform')}
let g:test#transformation = 'docker'
