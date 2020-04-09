#!/usr/bin/env nextflow

params.data_folder = './data/alan'
params.metadata_file = './data/alan/metadata.csv'

//params.data_folder = './data/daniel'
//params.metadata_file = './data/daniel/metadata.csv'

input_data_folder_ch = Channel.fromPath(params.data_folder)
input_metadata_ch = Channel.fromPath(params.metadata_file)

params.outdir = "$baseDir/output_nf"

process process {
    echo true

    publishDir "$params.outdir", mode: 'copy'

    input:
    file data_folder from input_data_folder_ch
    file metadata from input_metadata_ch

    output:
    file 'output_eic_params.tsv'
    file 'output_group_params.tsv'

    """
    run_autotuner.R $metadata $data_folder output_eic_params.tsv output_group_params.tsv
    """
}