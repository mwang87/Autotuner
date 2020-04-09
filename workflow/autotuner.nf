#!/usr/bin/env nextflow

params.data_folder = './data'
input_data_folder_ch = Channel.fromPath(params.data_folder)

params.metadata_file = './data/metadata.csv'
input_metadata_ch = Channel.fromPath(params.metadata_file)

params.outdir = "$baseDir/output_nf"

process process {
    echo true

    publishDir "$params.outdir", mode: 'copy'

    input:
    file data_folder from input_data_folder_ch
    file metadata from input_metadata_ch

    output:
    file 'output_params.tsv'

    """
    run_autotuner.R $metadata $data_folder output_params.tsv
    """
}