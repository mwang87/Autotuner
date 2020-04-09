#!/usr/bin/env nextflow

params.data_folder = './data'
input_data_folder_ch = Channel.fromPath(params.data_folder)

params.metadata_file = './data/metadata.csv'
input_metadata_ch = Channel.fromPath(params.metadata_file)


process process {
    echo true

    input:
    file data_folder from input_data_folder_ch
    file metadata from input_metadata_ch

    //output:
    //stdout result

    """
    run_autotuner.R $metadata $data_folder
    ls -l -h $metadata $data_folder
    """
}