<p align="center">
<img src="https://github.com/qlyoung/lagopus/blob/master/etc/lagopus.svg" alt="The project logo; a stylized Arctic fox head" width="20%"/>
</p>

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

  helm repo add lagopus https://stl315149.github.io/lagopus

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
stl314159` to see the charts.

To install the lagopus chart:

    helm install lagopus stl314159/lagopus

To uninstall the chart:

    helm delete lagopus
