import os
import sys
import json
import batchConv
import generateTestInputs
import glob
import shutil
from time import sleep
import argparse
cwd = os.getcwd()
script_dir = os.path.dirname(os.path.abspath(__file__))
info_query = os.path.join(script_dir, 'scripts', 'AutographScripts', 'info_design_comp.csv')
jenkins_run_script = os.path.join(script_dir, 'scripts', 'JenkinsScripts', 'JenkinsRunScript.csv')
component_info_file = os.path.join(cwd, 'info_corpusComponents2.json')
sys.path.append(os.path.join(script_dir, '..\\..\\autograph'))
from AutoGraph import runQuery
sys.path.append(os.path.join(script_dir, '..\\..\\Evaluations\\Evaltools'))
from EvalAllDesigns import runJenkins


def copy_to_docker(graphml_directory, ip_address, key_file):
    shutil.make_archive(graphml_directory, format='gztar', root_dir=graphml_directory)
    archive_name = os.path.basename(graphml_directory)+'.tar.gz'
    transfer_template = "scp -i {0} {1} ec2-user@{2}:."
    copy_template = 'ssh ec2-user@{0} -i {1} "docker cp {2} jce-jg:/opt/janusgraph/corpus"'
    unzip_template = 'ssh ec2-user@{0} -i {1} "docker exec -u 0 jce-jg tar -xf corpus/{2} --directory corpus"'
    pwd_template = 'ssh ec2-user@{0} -i {1} "docker exec -u 0 -it jce-jg pwd"'
    transfer_cmd = transfer_template.format(key_file,graphml_directory+'.tar.gz',ip_address)
    copy_cmd = copy_template.format(ip_address,key_file,archive_name)
    pwd_cmd = pwd_template.format(ip_address,key_file)
    print(f"Transferring Files to server: {transfer_cmd}")
    os.system(transfer_cmd)
    sleep(30)
    print(f"Copying Files: {copy_cmd}")
    os.system(copy_cmd)
    sleep(30)
    os.system(pwd_cmd)
    unzip_cmd = unzip_template.format(ip_address,key_file,archive_name)
    print(f"Unzipping Archive: {unzip_cmd}")
    os.system(unzip_cmd)

def copy_from_docker(graphml_directory, all_schema_name, ip_address, key_file):
    # MM not tested yet
    copy_template = f'ssh ec2-user@{0} -i {1} "docker cp jce-jg:/opt/janusgraph/corpus/{all_schema_name}* {graphml_directory}"'
    copy_command = copy_template.format(ip_address, key_file)
    os.system(copy_command)
    sleep(10)

def get_model_name_from_path(model_path):
    updated_path = os.path.splitext(model_path)
    if updated_path[1] != "":
        print(updated_path[1])
        get_model_name_from_path(updated_path[1])
    return os.path.basename(updated_path[0])

def main(ip_address, acm_directory, mapper_dir, graphml_directory, jenkins_ip=None, adm=None, schema=None, local=True, clear=False):
    key_file = "C:\\Users\Administrator\.ssh\swri_transfer_id_rsa"
    autograph_script = batchConv.convert_to_graphml(acm_directory,
                                                    graphml_directory=graphml_directory,
                                                    adm_directory=adm,
                                                    report_directory=graphml_directory,
                                                    comp_testing=jenkins_ip,
                                                    local=local,
                                                    all_schema_name=schema,
                                                    clear=clear,
                                                    symcps_dir=mapper_dir)
    if not local:
        copy_to_docker(graphml_directory, ip_address, key_file)
    runQuery(ip_address, autograph_script, cwd)
    if not local and schema is not None:
        copy_from_docker(graphml_directory, schema, ip_address, key_file)


    if jenkins_ip:
        runQuery(ip_address, info_query, cwd)
        with open(component_info_file, 'r') as f1:
            corpus_info = json.load(f1)

        autograph_dir = generateTestInputs.generate_component_input_deck(corpus_info)

        autograph_files = glob.glob(os.path.join(autograph_dir, '*.csv'))
        for file in autograph_files:
            runQuery(ip_address, file, cwd)
            model_name = get_model_name_from_path(file)
            print(model_name)
            results_dir = os.path.join(cwd, 'comp_results', model_name)
            print(results_dir)
            runJenkins(host=jenkins_ip, jenkins_output_file=jenkins_run_script, artifacts=True, artifacts_dir=results_dir)
            break

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description= '''Script for converting ACMs and ADMs then loading them to a JanusGraph database, then testing those components through a jenkins pipeline.''')
    parser.add_argument('janus_ip', type=str, default='localhost', action='store',
                        help='IP Address of Janusgraph. (default: localhost)')
    parser.add_argument('acm', type=str, action='store',
                        help='Directory for of ACMs to be converted and loaded.)')
    parser.add_argument('mapper_dir', type=str, action='store',
                        help='Directory for of ACMs to be converted and loaded.)')
    parser.add_argument('--adm', type=str, default=None, action='store',
                        help='Directory of ADMs to be loaded. If None then the ACMs directory will be used. Not Implimented. (default: None)')
    parser.add_argument('--jenkins_ip', type=str, default=None, action='store',
                        help='IP Address of Jenkins instance to be used for testing. (default: localhost)')
    parser.add_argument('--graphml', type=str, default='/NewDeploy/graph_ml', action='store',
                        help=' Location to store converted ACMs (default: /NewDeploy/graph_ml)')
    parser.add_argument('--schema', type=str, default=None, action='store',
                        help='Name of generated all schema. It not provided the schema will not be generated. (default: None)')
    parser.add_argument('--local', default=False, action='store_true',
                        help='Flag to run using local janusgraph instead of in a docker image.')
    parser.add_argument('--clear', default=False, action='store_true',
                        help='Flag to clear janusgraph before loading in corpus')

    args = parser.parse_args()

    # ip_address = sys.argv[1]
    # acm_directory = sys.argv[2]
    # graphml_directory = sys.argv[3]
    # jenkins_ip = None
    # if len(sys.argv)>=5:
    #     jenkins_ip = sys.argv[4]
    print(args)
    main(args.janus_ip, args.acm, args.mapper_dir, args.graphml, args.jenkins_ip, args.adm, args.schema, args.local, args.clear)