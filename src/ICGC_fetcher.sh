#!/bin/bash


main() {
    set -e -x -o pipefail

    dx-download-all-inputs

    # Check that only 1 of object-id(s) and manifest is defined
    if [ ${#object_ids[@]} -eq 0 && -z $manifest ]; then
        dx-jobutil-report-error "Expected input for either object_ids OR manifest, but received none." AppError
    fi

    if [ ${#object_ids[@]} -ne 0 && -n $manifest]; then
        dx-jobutil-report-error "Expected input for either object_ids OR manifest, but received both." AppError
    fi

    # Install java8 dependencies through apt-get
    rm -f /etc/apt/apt.conf.d/99dnanexus

    add-apt-repository -y ppa:webupd8team/java
    apt-get -qq update
    apt-get -qq upgrade -y

    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections

    sudo apt-get clean
    echo 'APT::Periodic::MaxSize "65536";' >> /etc/apt/apt.conf.d/99local-archive

    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq oracle-java8-installer
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq oracle-java8-set-default

    # Prepare output folder
    mkdir -p ~/out/output_files/

    # Move into icgc storage client folder (unpacked from bundle-depends)
    cd /icgc-storage-client-1.0.0

    # Update access token
    sed -i "s/accessToken=/accessToken=$access_token/g" conf/application.properties
    cd bin

    if [ ${#object_ids[@]} -ne 0 ]; then
        for id in "${object_ids[@]}"; do
            ./icgc-storage-client download --object-id "${id}" --output-dir ~/out/output_files/
        done
    else
        ./icgc-storage-client download --manifest $manifest_path --output-dir ~/out/output_files/
    fi


    sleep 3600

    dx-upload-all-outputs
}
