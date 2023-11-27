#       k8s.io/api v0.26.2
# [1] git ls-remote https://github.com/kubernetes/api 1528256abbdf8ff2510112b28a6aacd239789a36
SRCREV_k8s.io-api="1528256abbdf8ff2510112b28a6aacd239789a36"
SRC_URI += "git://github.com/kubernetes/api;name=k8s.io-api;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/k8s.io/api"

#       k8s.io/utils v0.0.0-20230220204549-a5ecb0141aa5
# [1] git ls-remote https://github.com/kubernetes/utils a5ecb0141aa5b1b224e745aca203afdfd22d8b3a
SRCREV_utils="a5ecb0141aa5b1b224e745aca203afdfd22d8b3a"
SRC_URI += "git://github.com/kubernetes/utils;name=utils;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/k8s.io/utils"

#       k8s.io/klog/v2 v2.90.1
# [1] git ls-remote https://github.com/kubernetes/klog d7fc50528570f8276de46570f916682257821e22
SRCREV_klog-v2="d7fc50528570f8276de46570f916682257821e22"
SRC_URI += "git://github.com/kubernetes/klog;name=klog-v2;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/k8s.io/klog/v2"

#       gotest.tools/v3 v3.5.0
# [1] git ls-remote https://github.com/gotestyourself/gotest.tools a80f057529047c44e1a85d0d017b200787e537e0
SRCREV_gotest.tools-v3="a80f057529047c44e1a85d0d017b200787e537e0"
SRC_URI += "git://github.com/gotestyourself/gotest.tools;name=gotest.tools-v3;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/gotest.tools/v3"

#       gopkg.in/inf.v0 v0.9.1
# [1] git ls-remote https://github.com/go-inf/inf d2d2541c53f18d2a059457998ce2876cc8e67cbf
SRCREV_inf.v0="d2d2541c53f18d2a059457998ce2876cc8e67cbf"
SRC_URI += "git://github.com/go-inf/inf;name=inf.v0;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/gopkg.in/inf.v0"

#       gopkg.in/ini.v1 v1.67.0
# [1] git ls-remote https://github.com/go-ini/ini b2f570e5b5b844226bbefe6fb521d891f529a951
SRCREV_ini.v1="b2f570e5b5b844226bbefe6fb521d891f529a951"
SRC_URI += "git://github.com/go-ini/ini;name=ini.v1;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/gopkg.in/ini.v1"

#       gopkg.in/yaml.v2 v2.4.0
# [1] git ls-remote https://github.com/go-yaml/yaml 7649d4548cb53a614db133b2a8ac1f31859dda8c
SRCREV_yaml.v2="7649d4548cb53a614db133b2a8ac1f31859dda8c"
SRC_URI += "git://github.com/go-yaml/yaml;name=yaml.v2;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/gopkg.in/yaml.v2"

#       golang.org/x/exp v0.0.0-20230713183714-613f0c0eb8a1
# [1] git ls-remote https://go.googlesource.com/exp 613f0c0eb8a17a98ecdb096a7f9f7d5053c1c963
SRCREV_exp="613f0c0eb8a17a98ecdb096a7f9f7d5053c1c963"
SRC_URI += "git://go.googlesource.com/exp;name=exp;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/golang.org/x/exp"

#       golang.org/x/mod v0.11.0
# [1] git ls-remote https://go.googlesource.com/mod 62c7e578f1a7275d934c99dd48715525bd52b17e
SRCREV_mod="62c7e578f1a7275d934c99dd48715525bd52b17e"
SRC_URI += "git://go.googlesource.com/mod;name=mod;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/golang.org/x/mod"

#       golang.org/x/net v0.9.0
# [1] git ls-remote https://go.googlesource.com/net 694cff8668bac64e0864b552bffc280cd27f21b1
SRCREV_net="694cff8668bac64e0864b552bffc280cd27f21b1"
SRC_URI += "git://go.googlesource.com/net;name=net;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/golang.org/x/net"

#       golang.org/x/sys v0.7.0
# [1] git ls-remote https://go.googlesource.com/sys 64840c112d2335ed9874114aed48f946e778a769
SRCREV_sys="64840c112d2335ed9874114aed48f946e778a769"
SRC_URI += "git://go.googlesource.com/sys;name=sys;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/golang.org/x/sys"

#       gopkg.in/yaml.v3 v3.0.1
# [1] git ls-remote https://github.com/go-yaml/yaml f6f7691b1fdeb513f56608cd2c32c51f8194bf51
SRCREV_yaml.v3="f6f7691b1fdeb513f56608cd2c32c51f8194bf51"
SRC_URI += "git://github.com/go-yaml/yaml;name=yaml.v3;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/gopkg.in/yaml.v3"

#       k8s.io/client-go v0.26.2
# [1] git ls-remote https://github.com/kubernetes/client-go 620cb60675340a9ca825fd5082b0d500f9b62e90
SRCREV_client-go="620cb60675340a9ca825fd5082b0d500f9b62e90"
SRC_URI += "git://github.com/kubernetes/client-go;name=client-go;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/k8s.io/client-go"

#       sigs.k8s.io/json v0.0.0-20220713155537-f223a00ba0e2
# [1] git ls-remote https://github.com/kubernetes-sigs/json f223a00ba0e27f539157f69f9c919c204ea7f40b
SRCREV_json="f223a00ba0e27f539157f69f9c919c204ea7f40b"
SRC_URI += "git://github.com/kubernetes-sigs/json;name=json;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/sigs.k8s.io/json"

#       sigs.k8s.io/yaml v1.3.0
# [1] git ls-remote https://github.com/kubernetes-sigs/yaml 9535b3b1e2893fe44efb37c5c9f5665e245d786a
SRCREV_yaml="9535b3b1e2893fe44efb37c5c9f5665e245d786a"
SRC_URI += "git://github.com/kubernetes-sigs/yaml;name=yaml;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/sigs.k8s.io/yaml"

#       golang.org/x/sync v0.3.0
# [1] git ls-remote https://go.googlesource.com/sync 93782cc822b6b554cb7df40332fd010f0473cbc8
SRCREV_sync="93782cc822b6b554cb7df40332fd010f0473cbc8"
SRC_URI += "git://go.googlesource.com/sync;name=sync;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/golang.org/x/sync"

#       golang.org/x/term v0.7.0
# [1] git ls-remote https://go.googlesource.com/term 7ae6be6d0150527c2c41e70586b9ade6a972a186
SRCREV_x-term="7ae6be6d0150527c2c41e70586b9ade6a972a186"
SRC_URI += "git://go.googlesource.com/term;name=x-term;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/golang.org/x/term"

#       golang.org/x/text v0.9.0
# [1] git ls-remote https://go.googlesource.com/text 48e4a4a957429d31328a685863b594ca9a06b552
SRCREV_text="48e4a4a957429d31328a685863b594ca9a06b552"
SRC_URI += "git://go.googlesource.com/text;name=text;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/golang.org/x/text"

#       golang.org/x/time v0.3.0
# [1] git ls-remote https://go.googlesource.com/time 2c09566ef13fb5556401ddff3c53c3dbc2a42dac
SRCREV_time="2c09566ef13fb5556401ddff3c53c3dbc2a42dac"
SRC_URI += "git://go.googlesource.com/time;name=time;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/golang.org/x/time"

#       go.uber.org/goleak v1.2.1
# [1] git ls-remote https://github.com/uber-go/goleak 83c7e126390f1508ca9cb8e87d70849b55181104
SRCREV_goleak="83c7e126390f1508ca9cb8e87d70849b55181104"
SRC_URI += "git://github.com/uber-go/goleak;name=goleak;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/go.uber.org/goleak"

#       golang.org/x/tools v0.7.0
# [1] git ls-remote https://go.googlesource.com/tools 031fc75960d487b0b15db12fb328676236a3a39c
SRCREV_tools="031fc75960d487b0b15db12fb328676236a3a39c"
SRC_URI += "git://go.googlesource.com/tools;name=tools;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/golang.org/x/tools"

#       github.com/adrg/xdg v0.4.0
# [1] git ls-remote https://github.com/adrg/xdg 4ec40e24f0cf1039f93c773f2984decdea9719b5
SRCREV_xdg="4ec40e24f0cf1039f93c773f2984decdea9719b5"
SRC_URI += "git://github.com/adrg/xdg;name=xdg;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/adrg/xdg"

#       golang.org/x/crypto v0.7.0
# [1] git ls-remote https://go.googlesource.com/crypto 776e461a4e6d8b372a43c72122c5c28cfc40dca2
SRCREV_crypto="776e461a4e6d8b372a43c72122c5c28cfc40dca2"
SRC_URI += "git://go.googlesource.com/crypto;name=crypto;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/golang.org/x/crypto"

#       golang.org/x/oauth2 v0.7.0
# [1] git ls-remote https://go.googlesource.com/oauth2 36075149c5b89480def496c735b8a1ba5fc63218
SRCREV_oauth2="36075149c5b89480def496c735b8a1ba5fc63218"
SRC_URI += "git://go.googlesource.com/oauth2;name=oauth2;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/golang.org/x/oauth2"

#       k8s.io/apimachinery v0.26.2
# [1] git ls-remote https://github.com/kubernetes/apimachinery 53ecdf01b997ca93c7db7615dfe7b27ad8391983
SRCREV_apimachinery="53ecdf01b997ca93c7db7615dfe7b27ad8391983"
SRC_URI += "git://github.com/kubernetes/apimachinery;name=apimachinery;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/k8s.io/apimachinery"

#       k8s.io/kube-openapi v0.0.0-20221012153701-172d655c2280
# [1] git ls-remote https://github.com/kubernetes/kube-openapi 172d655c2280350c77cf05962948fc67ff043492
SRCREV_kube-openapi="172d655c2280350c77cf05962948fc67ff043492"
SRC_URI += "git://github.com/kubernetes/kube-openapi;name=kube-openapi;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/k8s.io/kube-openapi"

#       github.com/moby/term v0.5.0
# [1] git ls-remote https://github.com/moby/term 9c3c875fad924eb6c9dd32a361b5fc0a49a4feb9
SRCREV_term="9c3c875fad924eb6c9dd32a361b5fc0a49a4feb9"
SRC_URI += "git://github.com/moby/term;name=term;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/moby/term"

#       github.com/docker/go v1.5.1-1.0.20160303222718-d30aec9fd63c
# [1] git ls-remote https://github.com/docker/go d30aec9fd63c35133f8f79c3412ad91a3b08be06
SRCREV_go="d30aec9fd63c35133f8f79c3412ad91a3b08be06"
SRC_URI += "git://github.com/docker/go;name=go;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/docker/go"

#       github.com/kr/pretty v0.3.0
# [1] git ls-remote https://github.com/kr/pretty a883a8422cd235c67c6c4fdcb7bbb022143e10b1
SRCREV_pretty="a883a8422cd235c67c6c4fdcb7bbb022143e10b1"
SRC_URI += "git://github.com/kr/pretty;name=pretty;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/kr/pretty"

#       github.com/docker/cli v24.0.5+incompatible
# [1] git ls-remote https://github.com/docker/cli ced099660009713e0e845eeb754e6050dbaa45d0
SRCREV_cli="ced099660009713e0e845eeb754e6050dbaa45d0"
SRC_URI += "git://github.com/docker/cli;name=cli;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/docker/cli"

#       github.com/pkg/errors v0.9.1
# [1] git ls-remote https://github.com/pkg/errors 614d223910a179a466c1767a985424175c39b465
SRCREV_errors="614d223910a179a466c1767a985424175c39b465"
SRC_URI += "git://github.com/pkg/errors;name=errors;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/pkg/errors"

#       github.com/gofrs/uuid v4.2.0+incompatible
# [1] git ls-remote https://github.com/gofrs/uuid 0c84a43ce25087b7041833685982950a65630d28
SRCREV_uuid="0c84a43ce25087b7041833685982950a65630d28"
SRC_URI += "git://github.com/gofrs/uuid;name=uuid;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/gofrs/uuid"

#       github.com/mgutz/ansi v0.0.0-20170206155736-9520e82c474b
# [1] git ls-remote https://github.com/mgutz/ansi 9520e82c474b0a04dd04f8a40959027271bab992
SRCREV_ansi="9520e82c474b0a04dd04f8a40959027271bab992"
SRC_URI += "git://github.com/mgutz/ansi;name=ansi;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/mgutz/ansi"

#       github.com/spf13/cast v1.5.0
# [1] git ls-remote https://github.com/spf13/cast 2b0eb0f724e320b655240e331aef36d1175986c2
SRCREV_cast="2b0eb0f724e320b655240e331aef36d1175986c2"
SRC_URI += "git://github.com/spf13/cast;name=cast;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/spf13/cast"

#       github.com/golang/mock v1.6.0
# [1] git ls-remote https://github.com/golang/mock aba2ff9a6844d5e3289e8472d3217d5b3090f083
SRCREV_mock="aba2ff9a6844d5e3289e8472d3217d5b3090f083"
SRC_URI += "git://github.com/golang/mock;name=mock;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/golang/mock"

#       github.com/spf13/cobra v1.7.0
# [1] git ls-remote https://github.com/spf13/cobra 4dd4b25de38418174a6e859e8a32eaccca32dccc
SRCREV_cobra="4dd4b25de38418174a6e859e8a32eaccca32dccc"
SRC_URI += "git://github.com/spf13/cobra;name=cobra;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/spf13/cobra"

#       github.com/spf13/pflag v1.0.5
# [1] git ls-remote https://github.com/spf13/pflag 2e9d26c8c37aae03e3f9d4e90b7116f5accb7cab
SRCREV_pflag="2e9d26c8c37aae03e3f9d4e90b7116f5accb7cab"
SRC_URI += "git://github.com/spf13/pflag;name=pflag;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/spf13/pflag"

#       google.golang.org/grpc v1.57.0
# [1] git ls-remote https://github.com/grpc/grpc-go 87bf02ad24f6cc071d2553eb5d62332194bba1fe
SRCREV_grpc="87bf02ad24f6cc071d2553eb5d62332194bba1fe"
SRC_URI += "git://github.com/grpc/grpc-go;name=grpc;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/google.golang.org/grpc"

#       github.com/gofrs/flock v0.8.1
# [1] git ls-remote https://github.com/gofrs/flock 6f010d1acea74a32f2f2066bfe324c08bbee30e3
SRCREV_flock="6f010d1acea74a32f2f2066bfe324c08bbee30e3"
SRC_URI += "git://github.com/gofrs/flock;name=flock;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/gofrs/flock"

#       github.com/gorilla/mux v1.8.0
# [1] git ls-remote https://github.com/gorilla/mux 98cb6bf42e086f6af920b965c38cacc07402d51b
SRCREV_mux="98cb6bf42e086f6af920b965c38cacc07402d51b"
SRC_URI += "git://github.com/gorilla/mux;name=mux;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/gorilla/mux"

#       github.com/jinzhu/gorm v1.9.11
# [1] git ls-remote https://github.com/jinzhu/gorm 81c17a7e2529c59efc4e74c5b32c1fb71fb12fa2
SRCREV_gorm="81c17a7e2529c59efc4e74c5b32c1fb71fb12fa2"
SRC_URI += "git://github.com/jinzhu/gorm;name=gorm;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/jinzhu/gorm"

#       github.com/moby/locker v1.0.1
# [1] git ls-remote https://github.com/moby/locker 281af2d563954745bea9d1487c965f24d30742fe
SRCREV_locker="281af2d563954745bea9d1487c965f24d30742fe"
SRC_URI += "git://github.com/moby/locker;name=locker;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/moby/locker"

#       github.com/rivo/uniseg v0.2.0
# [1] git ls-remote https://github.com/rivo/uniseg 75711fccf6a3e85bc74c241e2dddd06a9bc9e53d
SRCREV_uniseg="75711fccf6a3e85bc74c241e2dddd06a9bc9e53d"
SRC_URI += "git://github.com/rivo/uniseg;name=uniseg;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/rivo/uniseg"

#       github.com/spf13/afero v1.9.2
# [1] git ls-remote https://github.com/spf13/afero 2a70f2bb2db1524bf2aa3ca0cfebefa8d6367b7b
SRCREV_afero="2a70f2bb2db1524bf2aa3ca0cfebefa8d6367b7b"
SRC_URI += "git://github.com/spf13/afero;name=afero;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/spf13/afero"

#       github.com/buger/goterm v1.0.4
# [1] git ls-remote https://github.com/buger/goterm a73545aae7d693f786ce4cc687460efca4845f31
SRCREV_goterm="a73545aae7d693f786ce4cc687460efca4845f31"
SRC_URI += "git://github.com/buger/goterm;name=goterm;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/buger/goterm"

#       github.com/morikuni/aec v1.0.0
# [1] git ls-remote https://github.com/morikuni/aec 39771216ff4c63d11f5e604076f9c45e8be1067b
SRCREV_aec="39771216ff4c63d11f5e604076f9c45e8be1067b"
SRC_URI += "git://github.com/morikuni/aec;name=aec;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/morikuni/aec"

#       github.com/beorn7/perks v1.0.1
# [1] git ls-remote https://github.com/beorn7/perks 37c8de3658fcb183f997c4e13e8337516ab753e6
SRCREV_perks="37c8de3658fcb183f997c4e13e8337516ab753e6"
SRC_URI += "git://github.com/beorn7/perks;name=perks;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/beorn7/perks"

#       github.com/go-logr/logr v1.2.4
# [1] git ls-remote https://github.com/go-logr/logr 4da5305ff29a64c62f54ad43ebbfcb5e1b015fb2
SRCREV_logr="4da5305ff29a64c62f54ad43ebbfcb5e1b015fb2"
SRC_URI += "git://github.com/go-logr/logr;name=logr;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/go-logr/logr"

#       github.com/go-logr/stdr v1.2.2
# [1] git ls-remote https://github.com/go-logr/stdr 521af2addfa7c81c8a65d0e85ed34bb6bb6dc262
SRCREV_stdr="521af2addfa7c81c8a65d0e85ed34bb6bb6dc262"
SRC_URI += "git://github.com/go-logr/stdr;name=stdr;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/go-logr/stdr"

#       github.com/google/shlex v0.0.0-20191202100458-e7afc7fbc510
# [1] git ls-remote https://github.com/google/shlex e7afc7fbc51079733e9468cdfd1efcd7d196cd1d
SRCREV_shlex="e7afc7fbc51079733e9468cdfd1efcd7d196cd1d"
SRC_URI += "git://github.com/google/shlex;name=shlex;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/google/shlex"

#       github.com/miekg/pkcs11 v1.1.1
# [1] git ls-remote https://github.com/miekg/pkcs11 f3481918a208bd212aa995a41f92d786eb418a7d
SRCREV_pkcs11="f3481918a208bd212aa995a41f92d786eb418a7d"
SRC_URI += "git://github.com/miekg/pkcs11;name=pkcs11;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/miekg/pkcs11"

#       github.com/zmap/zcrypto v0.0.0-20220605182715-4dfcec6e9a8c
# [1] git ls-remote https://github.com/zmap/zcrypto 4dfcec6e9a8c2014f73dd584e64dc797129d77b8
SRCREV_zcrypto="4dfcec6e9a8c2014f73dd584e64dc797129d77b8"
SRC_URI += "git://github.com/zmap/zcrypto;name=zcrypto;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/zmap/zcrypto"

#       github.com/docker/buildx v0.11.2
# [1] git ls-remote https://github.com/docker/buildx 9872040b6626fb7d87ef7296fd5b832e8cc2ad17
SRCREV_buildx="9872040b6626fb7d87ef7296fd5b832e8cc2ad17"
SRC_URI += "git://github.com/docker/buildx;name=buildx;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/docker/buildx"

#       github.com/docker/docker v24.0.5+incompatible
# [1] git ls-remote https://github.com/moby/moby a61e2b4c9c5f7c241aeb37f389b4444aee26bea4
SRCREV_docker="a61e2b4c9c5f7c241aeb37f389b4444aee26bea4"
SRC_URI += "git://github.com/moby/moby;name=docker;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/docker/docker"

#       github.com/moby/buildkit v0.12.1
# [1] git ls-remote https://github.com/moby/buildkit bb857a0d49f45aa0ce9cd554b78d4075553e20f9
SRCREV_buildkit="bb857a0d49f45aa0ce9cd554b78d4075553e20f9"
SRC_URI += "git://github.com/moby/buildkit;name=buildkit;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/moby/buildkit"

#       go.opentelemetry.io/otel v1.14.0
# [1] git ls-remote https://github.com/open-telemetry/opentelemetry-go 2e54fbb3fede5b54f316b3a08eab236febd854e0
SRCREV_otel="2e54fbb3fede5b54f316b3a08eab236febd854e0"
SRC_URI += "git://github.com/open-telemetry/opentelemetry-go;name=otel;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/go.opentelemetry.io/otel"

#       github.com/aws/smithy-go v1.13.5
# [1] git ls-remote https://github.com/aws/smithy-go 296783feb4cb708355148913a16a624ae6b7db2f
SRCREV_smithy-go="296783feb4cb708355148913a16a624ae6b7db2f"
SRC_URI += "git://github.com/aws/smithy-go;name=smithy-go;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/aws/smithy-go"

#       github.com/gogo/protobuf v1.3.2
# [1] git ls-remote https://github.com/gogo/protobuf b03c65ea87cdc3521ede29f62fe3ce239267c1bc
SRCREV_protobuf="b03c65ea87cdc3521ede29f62fe3ce239267c1bc"
SRC_URI += "git://github.com/gogo/protobuf;name=protobuf;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/gogo/protobuf"

#       github.com/google/go-cmp v0.5.9
# [1] git ls-remote https://github.com/google/go-cmp a97318bf6562f2ed2632c5f985db51b1bc5bdcd0
SRCREV_go-cmp="a97318bf6562f2ed2632c5f985db51b1bc5bdcd0"
SRC_URI += "git://github.com/google/go-cmp;name=go-cmp;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/google/go-cmp"

#       github.com/google/gofuzz v1.2.0
# [1] git ls-remote https://github.com/google/gofuzz 379e164120fbc98885a8f494b5aa41ba94f64c56
SRCREV_gofuzz="379e164120fbc98885a8f494b5aa41ba94f64c56"
SRC_URI += "git://github.com/google/gofuzz;name=gofuzz;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/google/gofuzz"

#       github.com/hashicorp/hcl v1.0.0
# [1] git ls-remote https://github.com/hashicorp/hcl 8cb6e5b959231cc1119e43259c4a608f9c51a241
SRCREV_hcl="8cb6e5b959231cc1119e43259c4a608f9c51a241"
SRC_URI += "git://github.com/hashicorp/hcl;name=hcl;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/hashicorp/hcl"

#       github.com/imdario/mergo v0.3.16
# [1] git ls-remote https://github.com/darccio/mergo 14fe2b165b83359196f820886a2b24f2771729e9
SRCREV_mergo="14fe2b165b83359196f820886a2b24f2771729e9"
SRC_URI += "git://github.com/darccio/mergo;name=mergo;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/imdario/mergo"

#       github.com/google/gnostic v0.5.7-v3refs
# [1] git ls-remote https://github.com/google/gnostic b49832d97d25b6a41cbe34ea12257924a934eeee
SRCREV_gnostic="b49832d97d25b6a41cbe34ea12257924a934eeee"
SRC_URI += "git://github.com/google/gnostic;name=gnostic;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/google/gnostic"

#       github.com/laurazard/godog v0.0.0-20220922095256-4c4b17abdae7
# [1] git ls-remote https://github.com/laurazard/godog 4c4b17abdae7fd4f9d35cfe391ca65d172b092e3
SRCREV_godog="4c4b17abdae7fd4f9d35cfe391ca65d172b092e3"
SRC_URI += "git://github.com/laurazard/godog;name=godog;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/laurazard/godog"

#       github.com/docker/go-units v0.5.0
# [1] git ls-remote https://github.com/docker/go-units e682442797b36348f8e1f98defdbf32bac0b6c6f
SRCREV_go-units="e682442797b36348f8e1f98defdbf32bac0b6c6f"
SRC_URI += "git://github.com/docker/go-units;name=go-units;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/docker/go-units"

#       github.com/sirupsen/logrus v1.9.3
# [1] git ls-remote https://github.com/sirupsen/logrus d40e25cd45ed9c6b2b66e6b97573a0413e4c23bd
SRCREV_logrus="d40e25cd45ed9c6b2b66e6b97573a0413e4c23bd"
SRC_URI += "git://github.com/sirupsen/logrus;name=logrus;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/sirupsen/logrus"

#       github.com/davecgh/go-spew v1.1.1
# [1] git ls-remote https://github.com/davecgh/go-spew 8991bc29aa16c548c550c7ff78260e27b9ab7c73
SRCREV_go-spew="8991bc29aa16c548c550c7ff78260e27b9ab7c73"
SRC_URI += "git://github.com/davecgh/go-spew;name=go-spew;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/davecgh/go-spew"

#       github.com/go-openapi/swag v0.19.14
# [1] git ls-remote https://github.com/go-openapi/swag c78fa6719bc3d4b977d19a09064feda1c07571af
SRCREV_swag="c78fa6719bc3d4b977d19a09064feda1c07571af"
SRC_URI += "git://github.com/go-openapi/swag;name=swag;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/go-openapi/swag"

#       github.com/gogo/googleapis v1.4.1
# [1] git ls-remote https://github.com/gogo/googleapis 1f0e43f50bc0606e385ffae1bc80b5b231dcd042
SRCREV_googleapis="1f0e43f50bc0606e385ffae1bc80b5b231dcd042"
SRC_URI += "git://github.com/gogo/googleapis;name=googleapis;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/gogo/googleapis"

#       github.com/golang/protobuf v1.5.3
# [1] git ls-remote https://github.com/golang/protobuf 5d5e8c018a13017f9d5b8bf4fad64aaa42a87308
SRCREV_golang-protobuf="5d5e8c018a13017f9d5b8bf4fad64aaa42a87308"
SRC_URI += "git://github.com/golang/protobuf;name=golang-protobuf;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/golang/protobuf"

#       github.com/mailru/easyjson v0.7.6
# [1] git ls-remote https://github.com/mailru/easyjson 8ab5ff9cd8e4e432e8b79f6c47d324a31dd803cf
SRCREV_easyjson="8ab5ff9cd8e4e432e8b79f6c47d324a31dd803cf"
SRC_URI += "git://github.com/mailru/easyjson;name=easyjson;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/mailru/easyjson"

#       github.com/mattn/go-isatty v0.0.17
# [1] git ls-remote https://github.com/mattn/go-isatty ed75e619dc0f0489fd4062163a7d061eaa249b9c
SRCREV_go-isatty="ed75e619dc0f0489fd4062163a7d061eaa249b9c"
SRC_URI += "git://github.com/mattn/go-isatty;name=go-isatty;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/mattn/go-isatty"

#       github.com/moby/spdystream v0.2.0
# [1] git ls-remote https://github.com/moby/spdystream dbc715126c0e3fa07721879c6d265b2b82c71e5b
SRCREV_spdystream="dbc715126c0e3fa07721879c6d265b2b82c71e5b"
SRC_URI += "git://github.com/moby/spdystream;name=spdystream;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/moby/spdystream"

#       github.com/moby/sys/signal v0.7.0
# [1] git ls-remote https://github.com/moby/sys b8d8fabf1fa5cf0de7c1a1729145eee854ea31f5
SRCREV_signal="b8d8fabf1fa5cf0de7c1a1729145eee854ea31f5"
SRC_URI += "git://github.com/moby/sys;name=signal;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/moby/sys/signal"

#       github.com/subosito/gotenv v1.4.1
# [1] git ls-remote https://github.com/subosito/gotenv d94fdbe829d24b31d6ac30b6beb28b6420c1778a
SRCREV_gotenv="d94fdbe829d24b31d6ac30b6beb28b6420c1778a"
SRC_URI += "git://github.com/subosito/gotenv;name=gotenv;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/subosito/gotenv"

#       google.golang.org/genproto v0.0.0-20230526161137-0005af68ea54
# [1] git ls-remote https://github.com/googleapis/go-genproto 0005af68ea5476a8b99ce94ab83ae4aaac864963
SRCREV_genproto="0005af68ea5476a8b99ce94ab83ae4aaac864963"
SRC_URI += "git://github.com/googleapis/go-genproto;name=genproto;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/google.golang.org/genproto"

#       google.golang.org/protobuf v1.30.0
# [1] git ls-remote https://github.com/protocolbuffers/protobuf-go f221882bfb484564f1714ae05f197dea2c76898d
SRCREV_google.golang.org-protobuf="f221882bfb484564f1714ae05f197dea2c76898d"
SRC_URI += "git://github.com/protocolbuffers/protobuf-go;name=google.golang.org-protobuf;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/google.golang.org/protobuf"

#       github.com/stretchr/testify v1.8.4
# [1] git ls-remote https://github.com/stretchr/testify f97607b89807936ac4ff96748d766cf4b9711f78
SRCREV_testify="f97607b89807936ac4ff96748d766cf4b9711f78"
SRC_URI += "git://github.com/stretchr/testify;name=testify;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/stretchr/testify"

#       github.com/cloudflare/cfssl v1.6.4
# [1] git ls-remote https://github.com/cloudflare/cfssl b4d0d877cac528f63db39dfb62d5c96cd3a32a0b
SRCREV_cfssl="b4d0d877cac528f63db39dfb62d5c96cd3a32a0b"
SRC_URI += "git://github.com/cloudflare/cfssl;name=cfssl;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/cloudflare/cfssl"

#       github.com/josharian/intern v1.0.0
# [1] git ls-remote https://github.com/josharian/intern 8e6ff32b3e7c0b018c43953085fe2ac330fe9acd
SRCREV_intern="8e6ff32b3e7c0b018c43953085fe2ac330fe9acd"
SRC_URI += "git://github.com/josharian/intern;name=intern;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/josharian/intern"

#       github.com/json-iterator/go v1.1.12
# [1] git ls-remote https://github.com/json-iterator/go 024077e996b048517130b21ea6bf12aa23055d3d
SRCREV_json-iterator-go="024077e996b048517130b21ea6bf12aa23055d3d"
SRC_URI += "git://github.com/json-iterator/go;name=json-iterator-go;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/json-iterator/go"

#       github.com/moby/sys/symlink v0.2.0
# [1] git ls-remote https://github.com/moby/sys 03b9f8d59a07f5206a2264105f4903a222aea964
SRCREV_symlink="03b9f8d59a07f5206a2264105f4903a222aea964"
SRC_URI += "git://github.com/moby/sys;name=symlink;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/moby/sys/symlink"

#       github.com/serialx/hashring v0.0.0-20190422032157-8b2912629002
# [1] git ls-remote https://github.com/serialx/hashring 8b2912629002c928de72c69aae20c8600bef41a6
SRCREV_hashring="8b2912629002c928de72c69aae20c8600bef41a6"
SRC_URI += "git://github.com/serialx/hashring;name=hashring;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/serialx/hashring"

#       github.com/tonistiigi/units v0.0.0-20180711220420-6950e57a87ea
# [1] git ls-remote https://github.com/tonistiigi/units 6950e57a87eaf136bbe44ef2ec8e75b9e3569de2
SRCREV_units="6950e57a87eaf136bbe44ef2ec8e75b9e3569de2"
SRC_URI += "git://github.com/tonistiigi/units;name=units;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/tonistiigi/units"

#       github.com/tonistiigi/vt100 v0.0.0-20230623042737-f9a4f7ef6531
# [1] git ls-remote https://github.com/tonistiigi/vt100 f9a4f7ef65311848d4d4791c649a178c8e97386b
SRCREV_vt100="f9a4f7ef65311848d4d4791c649a178c8e97386b"
SRC_URI += "git://github.com/tonistiigi/vt100;name=vt100;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/tonistiigi/vt100"

#       google.golang.org/appengine v1.6.7
# [1] git ls-remote https://github.com/golang/appengine 5d1c1d03f8703c2e81478d9a30e9afa2d3e4bd8a
SRCREV_appengine="5d1c1d03f8703c2e81478d9a30e9afa2d3e4bd8a"
SRC_URI += "git://github.com/golang/appengine;name=appengine;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/google.golang.org/appengine"

#       github.com/fsnotify/fsevents v0.1.1
# [1] git ls-remote https://github.com/fsnotify/fsevents f721bd2b045774a566e8f7f5fa2a9985e04c875d
SRCREV_fsevents="f721bd2b045774a566e8f7f5fa2a9985e04c875d"
SRC_URI += "git://github.com/fsnotify/fsevents;name=fsevents;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/fsnotify/fsevents"

#       github.com/tilt-dev/fsnotify v1.4.8-0.20220602155310-fff9c274a375
# [1] git ls-remote https://github.com/tilt-dev/fsnotify fff9c274a375301ae46812f257aa68393790c45b
SRCREV_fsnotify="fff9c274a375301ae46812f257aa68393790c45b"
SRC_URI += "git://github.com/tilt-dev/fsnotify;name=fsnotify;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/tilt-dev/fsnotify"

#       go.opentelemetry.io/otel/sdk v1.14.0
# [1] git ls-remote https://github.com/open-telemetry/opentelemetry-go 2e54fbb3fede5b54f316b3a08eab236febd854e0
SRCREV_sdk="2e54fbb3fede5b54f316b3a08eab236febd854e0"
SRC_URI += "git://github.com/open-telemetry/opentelemetry-go;name=sdk;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/go.opentelemetry.io/otel/sdk"

#       github.com/Azure/go-ansiterm v0.0.0-20210617225240-d185dfc1b5a1
# [1] git ls-remote https://github.com/Azure/go-ansiterm d185dfc1b5a126116ea5a19e148e29d16b4574c9
SRCREV_go-ansiterm="d185dfc1b5a126116ea5a19e148e29d16b4574c9"
SRC_URI += "git://github.com/Azure/go-ansiterm;name=go-ansiterm;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/Azure/go-ansiterm"

#       github.com/aws/aws-sdk-go-v2 v1.17.6
# [1] git ls-remote https://github.com/aws/aws-sdk-go-v2 18bff5e44f4c2c140feaf54b2dd92140630c7e50
SRCREV_aws-sdk-go-v2="18bff5e44f4c2c140feaf54b2dd92140630c7e50"
SRC_URI += "git://github.com/aws/aws-sdk-go-v2;name=aws-sdk-go-v2;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/aws/aws-sdk-go-v2"

#       github.com/cespare/xxhash/v2 v2.2.0
# [1] git ls-remote https://github.com/cespare/xxhash a76eb16a93c1e30527c073ca831d9048b4b935f6
SRCREV_xxhash-v2="a76eb16a93c1e30527c073ca831d9048b4b935f6"
SRC_URI += "git://github.com/cespare/xxhash;name=xxhash-v2;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/cespare/xxhash/v2"

#       github.com/docker/go-metrics v0.0.1
# [1] git ls-remote https://github.com/docker/go-metrics b619b3592b65de4f087d9f16863a7e6ff905973c
SRCREV_go-metrics="b619b3592b65de4f087d9f16863a7e6ff905973c"
SRC_URI += "git://github.com/docker/go-metrics;name=go-metrics;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/docker/go-metrics"

#       github.com/felixge/httpsnoop v1.0.3
# [1] git ls-remote https://github.com/felixge/httpsnoop ef9fc62cdc3cc5abc33d6018fe1324890bb48145
SRCREV_httpsnoop="ef9fc62cdc3cc5abc33d6018fe1324890bb48145"
SRC_URI += "git://github.com/felixge/httpsnoop;name=httpsnoop;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/felixge/httpsnoop"

#       github.com/hashicorp/errwrap v1.1.0
# [1] git ls-remote https://github.com/hashicorp/errwrap 7b00e5db719c64d14dd0caaacbd13e76254d02c0
SRCREV_errwrap="7b00e5db719c64d14dd0caaacbd13e76254d02c0"
SRC_URI += "git://github.com/hashicorp/errwrap;name=errwrap;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/hashicorp/errwrap"

#       github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822
# [1] git ls-remote https://github.com/munnerz/goautoneg a7dc8b61c822528f973a5e4e7b272055c6fdb43e
SRCREV_goautoneg="a7dc8b61c822528f973a5e4e7b272055c6fdb43e"
SRC_URI += "git://github.com/munnerz/goautoneg;name=goautoneg;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/munnerz/goautoneg"

#       github.com/pelletier/go-toml v1.9.5
# [1] git ls-remote https://github.com/pelletier/go-toml fed1464066413075eac02cd4dc368b5221845541
SRCREV_go-toml="fed1464066413075eac02cd4dc368b5221845541"
SRC_URI += "git://github.com/pelletier/go-toml;name=go-toml;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/pelletier/go-toml"

#       github.com/prometheus/common v0.42.0
# [1] git ls-remote https://github.com/prometheus/common 66b493f42b757378fbad83e42b0ed441d425a17b
SRCREV_common="66b493f42b757378fbad83e42b0ed441d425a17b"
SRC_URI += "git://github.com/prometheus/common;name=common;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/prometheus/common"

#       github.com/prometheus/procfs v0.9.0
# [1] git ls-remote https://github.com/prometheus/procfs bb7727a9ca9b3cd1559b42ffa74e13ef7efb6283
SRCREV_procfs="bb7727a9ca9b3cd1559b42ffa74e13ef7efb6283"
SRC_URI += "git://github.com/prometheus/procfs;name=procfs;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/prometheus/procfs"

#       github.com/tonistiigi/fsutil v0.0.0-20230629203738-36ef4d8c0dbb
# [1] git ls-remote https://github.com/tonistiigi/fsutil 36ef4d8c0dbba81b41fcfe7a03ba1f6ba56904f2
SRCREV_fsutil="36ef4d8c0dbba81b41fcfe7a03ba1f6ba56904f2"
SRC_URI += "git://github.com/tonistiigi/fsutil;name=fsutil;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/tonistiigi/fsutil"

#       github.com/Microsoft/go-winio v0.6.1
# [1] git ls-remote https://github.com/microsoft/go-winio 070c828abb873da9e71c7247740253b50f7cf049
SRCREV_go-winio="070c828abb873da9e71c7247740253b50f7cf049"
SRC_URI += "git://github.com/microsoft/go-winio;name=go-winio;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/Microsoft/go-winio"

#       github.com/containerd/console v1.0.3
# [1] git ls-remote https://github.com/containerd/console b5cb846c9186d67bcae3ce3c324e47cd317d9527
SRCREV_console="b5cb846c9186d67bcae3ce3c324e47cd317d9527"
SRC_URI += "git://github.com/containerd/console;name=console;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/containerd/console"

#       github.com/bugsnag/bugsnag-go v1.5.0
# [1] git ls-remote https://github.com/bugsnag/bugsnag-go d5b63da7e1f93d83e3980e5ab2bf33179bad7b2a
SRCREV_bugsnag-go="d5b63da7e1f93d83e3980e5ab2bf33179bad7b2a"
SRC_URI += "git://github.com/bugsnag/bugsnag-go;name=bugsnag-go;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/bugsnag/bugsnag-go"

#       github.com/fvbommel/sortorder v1.0.2
# [1] git ls-remote https://github.com/fvbommel/sortorder 26fad50c6b32a3064c09ed089865c16f2f3615f6
SRCREV_sortorder="26fad50c6b32a3064c09ed089865c16f2f3615f6"
SRC_URI += "git://github.com/fvbommel/sortorder;name=sortorder;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/fvbommel/sortorder"

#       github.com/hashicorp/go-memdb v1.3.2
# [1] git ls-remote https://github.com/hashicorp/go-memdb 542a5804dedaaddf1a0cad8b6a7b0b3fcf438776
SRCREV_go-memdb="542a5804dedaaddf1a0cad8b6a7b0b3fcf438776"
SRC_URI += "git://github.com/hashicorp/go-memdb;name=go-memdb;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/hashicorp/go-memdb"

#       github.com/klauspost/compress v1.16.5
# [1] git ls-remote https://github.com/klauspost/compress ed6feffc3bb26797dc2a376516b16611046cdecd
SRCREV_compress="ed6feffc3bb26797dc2a376516b16611046cdecd"
SRC_URI += "git://github.com/klauspost/compress;name=compress;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/klauspost/compress"

#       github.com/mattn/go-colorable v0.1.13
# [1] git ls-remote https://github.com/mattn/go-colorable 11a925cff3d38c293ddc8c05a16b504e3e2c63be
SRCREV_go-colorable="11a925cff3d38c293ddc8c05a16b504e3e2c63be"
SRC_URI += "git://github.com/mattn/go-colorable;name=go-colorable;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/mattn/go-colorable"

#       github.com/mattn/go-runewidth v0.0.14
# [1] git ls-remote https://github.com/mattn/go-runewidth 2c6a438f68cfe01255a90824599da41fdf76d1e2
SRCREV_go-runewidth="2c6a438f68cfe01255a90824599da41fdf76d1e2"
SRC_URI += "git://github.com/mattn/go-runewidth;name=go-runewidth;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/mattn/go-runewidth"

#       github.com/moby/sys/mountinfo v0.6.2
# [1] git ls-remote https://github.com/moby/sys 1bf36f7188c31f2797c556c4c4d7d9af7a6a965b
SRCREV_mountinfo="1bf36f7188c31f2797c556c4c4d7d9af7a6a965b"
SRC_URI += "git://github.com/moby/sys;name=mountinfo;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/moby/sys/mountinfo"

#       github.com/modern-go/reflect2 v1.0.2
# [1] git ls-remote https://github.com/modern-go/reflect2 2b33151c9bbc5231aea69b8861c540102b087070
SRCREV_reflect2="2b33151c9bbc5231aea69b8861c540102b087070"
SRC_URI += "git://github.com/modern-go/reflect2;name=reflect2;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/modern-go/reflect2"

#       github.com/pmezard/go-difflib v1.0.0
# [1] git ls-remote https://github.com/pmezard/go-difflib 792786c7400a136282c1664665ae0a8db921c6c2
SRCREV_go-difflib="792786c7400a136282c1664665ae0a8db921c6c2"
SRC_URI += "git://github.com/pmezard/go-difflib;name=go-difflib;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/pmezard/go-difflib"

#       github.com/jonboulle/clockwork v0.4.0
# [1] git ls-remote https://github.com/jonboulle/clockwork 606c48b92358fcca153952b56fb0d14d6845f84a
SRCREV_clockwork="606c48b92358fcca153952b56fb0d14d6845f84a"
SRC_URI += "git://github.com/jonboulle/clockwork;name=clockwork;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/jonboulle/clockwork"

#       github.com/mattn/go-shellwords v1.0.12
# [1] git ls-remote https://github.com/mattn/go-shellwords 973b9d5391598d4ee601db46fa32f6e186a356ac
SRCREV_go-shellwords="973b9d5391598d4ee601db46fa32f6e186a356ac"
SRC_URI += "git://github.com/mattn/go-shellwords;name=go-shellwords;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/mattn/go-shellwords"

#       github.com/moby/patternmatcher v0.6.0
# [1] git ls-remote https://github.com/moby/patternmatcher 347bb8d8d557f90d1b75cd8bca3c0177f380a979
SRCREV_patternmatcher="347bb8d8d557f90d1b75cd8bca3c0177f380a979"
SRC_URI += "git://github.com/moby/patternmatcher;name=patternmatcher;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/moby/patternmatcher"

#       go.opentelemetry.io/otel/trace v1.14.0
# [1] git ls-remote https://github.com/open-telemetry/opentelemetry-go 2e54fbb3fede5b54f316b3a08eab236febd854e0
SRCREV_trace="2e54fbb3fede5b54f316b3a08eab236febd854e0"
SRC_URI += "git://github.com/open-telemetry/opentelemetry-go;name=trace;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/go.opentelemetry.io/otel/trace"

#       github.com/cenkalti/backoff/v4 v4.2.0
# [1] git ls-remote https://github.com/cenkalti/backoff e5c9822f4eaffe6a2abac94d7fbf85380dd629a8
SRCREV_v4="e5c9822f4eaffe6a2abac94d7fbf85380dd629a8"
SRC_URI += "git://github.com/cenkalti/backoff;name=v4;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/cenkalti/backoff/v4"

#       github.com/docker/distribution v2.8.2+incompatible
# [1] git ls-remote https://github.com/distribution/distribution 7c354a4b40feeea21d7eeae4de91c8ff7951e672
SRCREV_distribution="7c354a4b40feeea21d7eeae4de91c8ff7951e672"
SRC_URI += "git://github.com/distribution/distribution;name=distribution;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/docker/distribution"

#       github.com/moby/sys/sequential v0.5.0
# [1] git ls-remote https://github.com/moby/sys b22ba8a69b306f0b4adbbe2a529457e6283ed9f7
SRCREV_sequential="b22ba8a69b306f0b4adbbe2a529457e6283ed9f7"
SRC_URI += "git://github.com/moby/sys;name=sequential;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/moby/sys/sequential"

#       github.com/opencontainers/runc v1.1.7
# [1] git ls-remote https://github.com/opencontainers/runc 860f061b76bb4fc671f0f9e900f7d80ff93d4eb7
SRCREV_runc="860f061b76bb4fc671f0f9e900f7d80ff93d4eb7"
SRC_URI += "git://github.com/opencontainers/runc;name=runc;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/opencontainers/runc"

#       github.com/shibumi/go-pathspec v1.3.0
# [1] git ls-remote https://github.com/shibumi/go-pathspec 30eddf187f62305a5b34f662049d077211abaacd
SRCREV_go-pathspec="30eddf187f62305a5b34f662049d077211abaacd"
SRC_URI += "git://github.com/shibumi/go-pathspec;name=go-pathspec;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/shibumi/go-pathspec"

#       go.opentelemetry.io/proto/otlp v0.19.0
# [1] git ls-remote https://github.com/open-telemetry/opentelemetry-proto-go c98f6b5f7362c9b4a717c7a4dab1ba90796a8f21
SRCREV_otlp="c98f6b5f7362c9b4a717c7a4dab1ba90796a8f21"
SRC_URI += "git://github.com/open-telemetry/opentelemetry-proto-go;name=otlp;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/go.opentelemetry.io/proto/otlp"

#       github.com/docker/cli-docs-tool v0.6.0
# [1] git ls-remote https://github.com/docker/cli-docs-tool 5cb124c70a1f08a8fcbffad5059b4b5b01123124
SRCREV_cli-docs-tool="5cb124c70a1f08a8fcbffad5059b4b5b01123124"
SRC_URI += "git://github.com/docker/cli-docs-tool;name=cli-docs-tool;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/docker/cli-docs-tool"

#       github.com/hashicorp/go-version v1.6.0
# [1] git ls-remote https://github.com/hashicorp/go-version 78d058c5618891f74d604bd15356fca690b64d8a
SRCREV_go-version="78d058c5618891f74d604bd15356fca690b64d8a"
SRC_URI += "git://github.com/hashicorp/go-version;name=go-version;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/hashicorp/go-version"

#       github.com/hashicorp/golang-lru v0.5.4
# [1] git ls-remote https://github.com/hashicorp/golang-lru 14eae340515388ca95aa8e7b86f0de668e981f54
SRCREV_golang-lru="14eae340515388ca95aa8e7b86f0de668e981f54"
SRC_URI += "git://github.com/hashicorp/golang-lru;name=golang-lru;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/hashicorp/golang-lru"

#       github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd
# [1] git ls-remote https://github.com/modern-go/concurrent bacd9c7ef1dd9b15be4a9909b8ac7a4e313eec94
SRCREV_concurrent="bacd9c7ef1dd9b15be4a9909b8ac7a4e313eec94"
SRC_URI += "git://github.com/modern-go/concurrent;name=concurrent;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/modern-go/concurrent"

#       github.com/pelletier/go-toml/v2 v2.0.5
# [1] git ls-remote https://github.com/pelletier/go-toml 942841787a7d70422e4d8bc7d0be28ab911402df
SRCREV_go-toml-v2="942841787a7d70422e4d8bc7d0be28ab911402df"
SRC_URI += "git://github.com/pelletier/go-toml;name=go-toml-v2;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/pelletier/go-toml/v2"

#       github.com/xeipuuv/gojsonschema v1.2.0
# [1] git ls-remote https://github.com/xeipuuv/gojsonschema 82fcdeb203eb6ab2a67d0a623d9c19e5e5a64927
SRCREV_gojsonschema="82fcdeb203eb6ab2a67d0a623d9c19e5e5a64927"
SRC_URI += "git://github.com/xeipuuv/gojsonschema;name=gojsonschema;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/xeipuuv/gojsonschema"

#       go.opentelemetry.io/otel/metric v0.37.0
# [1] git ls-remote https://github.com/open-telemetry/opentelemetry-go 2e54fbb3fede5b54f316b3a08eab236febd854e0
SRCREV_metric="2e54fbb3fede5b54f316b3a08eab236febd854e0"
SRC_URI += "git://github.com/open-telemetry/opentelemetry-go;name=metric;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/go.opentelemetry.io/otel/metric"

#       github.com/AlecAivazis/survey/v2 v2.3.7
# [1] git ls-remote https://github.com/AlecAivazis/survey fa37277e6394c29db7bcc94062cb30cd7785a126
SRCREV_v2="fa37277e6394c29db7bcc94062cb30cd7785a126"
SRC_URI += "git://github.com/AlecAivazis/survey;name=v2;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/AlecAivazis/survey/v2"

#       github.com/containerd/containerd v1.7.3
# [1] git ls-remote https://github.com/containerd/containerd 7880925980b188f4c97b462f709d0db8e8962aff
SRCREV_containerd="7880925980b188f4c97b462f709d0db8e8962aff"
SRC_URI += "git://github.com/containerd/containerd;name=containerd;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/containerd/containerd"

#       github.com/docker/go-connections v0.4.0
# [1] git ls-remote https://github.com/docker/go-connections 7395e3f8aa162843a74ed6d48e79627d9792ac55
SRCREV_go-connections="7395e3f8aa162843a74ed6d48e79627d9792ac55"
SRC_URI += "git://github.com/docker/go-connections;name=go-connections;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/docker/go-connections"

#       github.com/Masterminds/semver/v3 v3.2.1
# [1] git ls-remote https://github.com/Masterminds/semver e06051f8fcc4c8b4a4990c337b9862a2448722e5
SRCREV_semver-v3="e06051f8fcc4c8b4a4990c337b9862a2448722e5"
SRC_URI += "git://github.com/Masterminds/semver;name=semver-v3;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/Masterminds/semver/v3"

#       github.com/containerd/continuity v0.4.1
# [1] git ls-remote https://github.com/containerd/continuity 25762ef7c27a37645197ed6d1d708e55a230e35d
SRCREV_continuity="25762ef7c27a37645197ed6d1d708e55a230e35d"
SRC_URI += "git://github.com/containerd/continuity;name=continuity;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/containerd/continuity"

#       github.com/containerd/typeurl/v2 v2.1.1
# [1] git ls-remote https://github.com/containerd/typeurl 7ef6316b771f959cbb208b229e3423a466947df3
SRCREV_typeurl-v2="7ef6316b771f959cbb208b229e3423a466947df3"
SRC_URI += "git://github.com/containerd/typeurl;name=typeurl-v2;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/containerd/typeurl/v2"

#       github.com/magiconair/properties v1.8.6
# [1] git ls-remote https://github.com/magiconair/properties 869a5592420f4ff6ebf74500b5c658b29d973172
SRCREV_properties="869a5592420f4ff6ebf74500b5c658b29d973172"
SRC_URI += "git://github.com/magiconair/properties;name=properties;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/magiconair/properties"

#       github.com/xeipuuv/gojsonpointer v0.0.0-20190905194746-02993c407bfb
# [1] git ls-remote https://github.com/xeipuuv/gojsonpointer 02993c407bfbf5f6dae44c4f4b1cf6a39b5fc5bb
SRCREV_gojsonpointer="02993c407bfbf5f6dae44c4f4b1cf6a39b5fc5bb"
SRC_URI += "git://github.com/xeipuuv/gojsonpointer;name=gojsonpointer;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/xeipuuv/gojsonpointer"

#       github.com/mitchellh/mapstructure v1.5.0
# [1] git ls-remote https://github.com/mitchellh/mapstructure ab69d8d93410fce4361f4912bb1ff88110a81311
SRCREV_mapstructure="ab69d8d93410fce4361f4912bb1ff88110a81311"
SRC_URI += "git://github.com/mitchellh/mapstructure;name=mapstructure;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/mitchellh/mapstructure"

#       github.com/emicklei/go-restful/v3 v3.10.1
# [1] git ls-remote https://github.com/emicklei/go-restful 96e1c78bfbbfa19bd826b27b3a8a8087ee3cb1d3
SRCREV_go-restful-v3="96e1c78bfbbfa19bd826b27b3a8a8087ee3cb1d3"
SRC_URI += "git://github.com/emicklei/go-restful;name=go-restful-v3;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/emicklei/go-restful/v3"

#       github.com/go-openapi/jsonpointer v0.19.5
# [1] git ls-remote https://github.com/go-openapi/jsonpointer 2446e21cad36eee826e1c2380f0ff747074a2faa
SRCREV_jsonpointer="2446e21cad36eee826e1c2380f0ff747074a2faa"
SRC_URI += "git://github.com/go-openapi/jsonpointer;name=jsonpointer;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/go-openapi/jsonpointer"

#       github.com/in-toto/in-toto-golang v0.5.0
# [1] git ls-remote https://github.com/in-toto/in-toto-golang ec599036d27ebaca3e8c03559d3f8fd5fe429dfe
SRCREV_in-toto-golang="ec599036d27ebaca3e8c03559d3f8fd5fe429dfe"
SRC_URI += "git://github.com/in-toto/in-toto-golang;name=in-toto-golang;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/in-toto/in-toto-golang"

#       github.com/kballard/go-shellquote v0.0.0-20180428030007-95032a82bc51
# [1] git ls-remote https://github.com/kballard/go-shellquote 95032a82bc518f77982ea72343cc1ade730072f0
SRCREV_go-shellquote="95032a82bc518f77982ea72343cc1ade730072f0"
SRC_URI += "git://github.com/kballard/go-shellquote;name=go-shellquote;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/kballard/go-shellquote"

#       github.com/compose-spec/compose-go v1.18.3
# [1] git ls-remote https://github.com/compose-spec/compose-go c6eecc55b95f952b6d6406adcd297499d11a300b
SRCREV_compose-go="c6eecc55b95f952b6d6406adcd297499d11a300b"
SRC_URI += "git://github.com/compose-spec/compose-go;name=compose-go;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/compose-spec/compose-go"

#       github.com/hashicorp/go-multierror v1.1.1
# [1] git ls-remote https://github.com/hashicorp/go-multierror 9974e9ec57696378079ecc3accd3d6f29401b3a0
SRCREV_go-multierror="9974e9ec57696378079ecc3accd3d6f29401b3a0"
SRC_URI += "git://github.com/hashicorp/go-multierror;name=go-multierror;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/hashicorp/go-multierror"

#       github.com/cucumber/gherkin-go/v19 v19.0.3
# [1] git ls-remote https://github.com/cucumber/gherkin-go 11029f28bd1bc215fa57275b576f2b237b7c2b07
SRCREV_v19="11029f28bd1bc215fa57275b576f2b237b7c2b07"
SRC_URI += "git://github.com/cucumber/gherkin-go;name=v19;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/cucumber/gherkin-go/v19"

#       github.com/prometheus/client_model v0.3.0
# [1] git ls-remote https://github.com/prometheus/client_model 63fb9822ca3ba7a4ba5184071fb8f2ea000a99ef
SRCREV_client_model="63fb9822ca3ba7a4ba5184071fb8f2ea000a99ef"
SRC_URI += "git://github.com/prometheus/client_model;name=client_model;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/prometheus/client_model"

#       github.com/spf13/jwalterweatherman v1.1.0
# [1] git ls-remote https://github.com/spf13/jwalterweatherman 94f6ae3ed3bceceafa716478c5fbf8d29ca601a1
SRCREV_jwalterweatherman="94f6ae3ed3bceceafa716478c5fbf8d29ca601a1"
SRC_URI += "git://github.com/spf13/jwalterweatherman;name=jwalterweatherman;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/spf13/jwalterweatherman"

#       github.com/xeipuuv/gojsonreference v0.0.0-20180127040603-bd5ef7bd5415
# [1] git ls-remote https://github.com/xeipuuv/gojsonreference bd5ef7bd5415a7ac448318e64f11a24cd21e594b
SRCREV_gojsonreference="bd5ef7bd5415a7ac448318e64f11a24cd21e594b"
SRC_URI += "git://github.com/xeipuuv/gojsonreference;name=gojsonreference;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/xeipuuv/gojsonreference"

#       github.com/opencontainers/go-digest v1.0.0
# [1] git ls-remote https://github.com/opencontainers/go-digest ea51bea511f75cfa3ef6098cc253c5c3609b037a
SRCREV_go-digest="ea51bea511f75cfa3ef6098cc253c5c3609b037a"
SRC_URI += "git://github.com/opencontainers/go-digest;name=go-digest;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/opencontainers/go-digest"

#       github.com/aws/aws-sdk-go-v2/config v1.18.16
# [1] git ls-remote https://github.com/aws/aws-sdk-go-v2 18bff5e44f4c2c140feaf54b2dd92140630c7e50
SRCREV_config="18bff5e44f4c2c140feaf54b2dd92140630c7e50"
SRC_URI += "git://github.com/aws/aws-sdk-go-v2;name=config;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/aws/aws-sdk-go-v2/config"

#       github.com/cucumber/messages-go/v16 v16.0.1
# [1] git ls-remote https://github.com/cucumber/messages-go 1848e9bfc84e8c1674c4d9ded0bdbfc23c458b28
SRCREV_v16="1848e9bfc84e8c1674c4d9ded0bdbfc23c458b28"
SRC_URI += "git://github.com/cucumber/messages-go;name=v16;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/cucumber/messages-go/v16"

#       github.com/go-openapi/jsonreference v0.20.0
# [1] git ls-remote https://github.com/go-openapi/jsonreference c5db5582e080fbeae80be42f42881230a8caebf6
SRCREV_jsonreference="c5db5582e080fbeae80be42f42881230a8caebf6"
SRC_URI += "git://github.com/go-openapi/jsonreference;name=jsonreference;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/go-openapi/jsonreference"

#       github.com/prometheus/client_golang v1.14.0
# [1] git ls-remote https://github.com/prometheus/client_golang 254e5468413f19fb75cdad45f5ddc0b8c975188c
SRCREV_client_golang="254e5468413f19fb75cdad45f5ddc0b8c975188c"
SRC_URI += "git://github.com/prometheus/client_golang;name=client_golang;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/prometheus/client_golang"

#       github.com/opencontainers/image-spec v1.1.0-rc4
# [1] git ls-remote https://github.com/opencontainers/image-spec 82e8329f7eb6df5c62924f2792d285ba276ae876
SRCREV_image-spec="82e8329f7eb6df5c62924f2792d285ba276ae876"
SRC_URI += "git://github.com/opencontainers/image-spec;name=image-spec;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/opencontainers/image-spec"

#       github.com/theupdateframework/notary v0.7.0
# [1] git ls-remote https://github.com/notaryproject/notary b0b6bfdd4933081e8d5ae026b24e8337311dd598
SRCREV_notary="b0b6bfdd4933081e8d5ae026b24e8337311dd598"
SRC_URI += "git://github.com/notaryproject/notary;name=notary;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/theupdateframework/notary"

#       github.com/AdaLogics/go-fuzz-headers v0.0.0-20230106234847-43070de90fa1
# [1] git ls-remote https://github.com/AdaLogics/go-fuzz-headers 43070de90fa134c9ea55cd6de4308a2ae59658d3
SRCREV_go-fuzz-headers="43070de90fa134c9ea55cd6de4308a2ae59658d3"
SRC_URI += "git://github.com/AdaLogics/go-fuzz-headers;name=go-fuzz-headers;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/AdaLogics/go-fuzz-headers"

#       github.com/inconshreveable/mousetrap v1.1.0
# [1] git ls-remote https://github.com/inconshreveable/mousetrap 4e8053ee7ef85a6bd26368364a6d27f1641c1d21
SRCREV_mousetrap="4e8053ee7ef85a6bd26368364a6d27f1641c1d21"
SRC_URI += "git://github.com/inconshreveable/mousetrap;name=mousetrap;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/inconshreveable/mousetrap"

#       sigs.k8s.io/structured-merge-diff/v4 v4.2.3
# [1] git ls-remote https://github.com/kubernetes-sigs/structured-merge-diff 26781d0c10bfdbd7d66b18d8be83985f623df9f8
SRCREV_structured-merge-diff-v4="26781d0c10bfdbd7d66b18d8be83985f623df9f8"
SRC_URI += "git://github.com/kubernetes-sigs/structured-merge-diff;name=structured-merge-diff-v4;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/sigs.k8s.io/structured-merge-diff/v4"

#       github.com/cyphar/filepath-securejoin v0.2.3
# [1] git ls-remote https://github.com/cyphar/filepath-securejoin 8f267f5ea675a20a2cb5e91011d063721f53bf79
SRCREV_filepath-securejoin="8f267f5ea675a20a2cb5e91011d063721f53bf79"
SRC_URI += "git://github.com/cyphar/filepath-securejoin;name=filepath-securejoin;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/cyphar/filepath-securejoin"

#       github.com/distribution/distribution/v3 v3.0.0-20230601133803-97b1d649c493
# [1] git ls-remote https://github.com/distribution/distribution 97b1d649c4938d0f608d96454d6a8326b1f96acd
SRCREV_v3="97b1d649c4938d0f608d96454d6a8326b1f96acd"
SRC_URI += "git://github.com/distribution/distribution;name=v3;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/distribution/distribution/v3"

#       github.com/hashicorp/go-immutable-radix v1.3.1
# [1] git ls-remote https://github.com/hashicorp/go-immutable-radix 49d1d02c49a783de548d1ba8ae8fde466a20b9e6
SRCREV_go-immutable-radix="49d1d02c49a783de548d1ba8ae8fde466a20b9e6"
SRC_URI += "git://github.com/hashicorp/go-immutable-radix;name=go-immutable-radix;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/hashicorp/go-immutable-radix"

#       github.com/aws/aws-sdk-go-v2/credentials v1.13.16
# [1] git ls-remote https://github.com/aws/aws-sdk-go-v2 18bff5e44f4c2c140feaf54b2dd92140630c7e50
SRCREV_credentials="18bff5e44f4c2c140feaf54b2dd92140630c7e50"
SRC_URI += "git://github.com/aws/aws-sdk-go-v2;name=credentials;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/aws/aws-sdk-go-v2/credentials"

#       github.com/aws/aws-sdk-go-v2/service/sso v1.12.5
# [1] git ls-remote https://github.com/aws/aws-sdk-go-v2 18bff5e44f4c2c140feaf54b2dd92140630c7e50
SRCREV_sso="18bff5e44f4c2c140feaf54b2dd92140630c7e50"
SRC_URI += "git://github.com/aws/aws-sdk-go-v2;name=sso;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/aws/aws-sdk-go-v2/service/sso"

#       github.com/aws/aws-sdk-go-v2/service/sts v1.18.6
# [1] git ls-remote https://github.com/aws/aws-sdk-go-v2 18bff5e44f4c2c140feaf54b2dd92140630c7e50
SRCREV_sts="18bff5e44f4c2c140feaf54b2dd92140630c7e50"
SRC_URI += "git://github.com/aws/aws-sdk-go-v2;name=sts;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/aws/aws-sdk-go-v2/service/sts"

#       github.com/aws/aws-sdk-go-v2/internal/ini v1.3.31
# [1] git ls-remote https://github.com/aws/aws-sdk-go-v2 18bff5e44f4c2c140feaf54b2dd92140630c7e50
SRCREV_ini="18bff5e44f4c2c140feaf54b2dd92140630c7e50"
SRC_URI += "git://github.com/aws/aws-sdk-go-v2;name=ini;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/aws/aws-sdk-go-v2/internal/ini"

#       github.com/grpc-ecosystem/grpc-gateway/v2 v2.11.3
# [1] git ls-remote https://github.com/grpc-ecosystem/grpc-gateway 0197faf8b072910084edd1209aa2ac51833b895c
SRCREV_grpc-gateway-v2="0197faf8b072910084edd1209aa2ac51833b895c"
SRC_URI += "git://github.com/grpc-ecosystem/grpc-gateway;name=grpc-gateway-v2;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/grpc-ecosystem/grpc-gateway/v2"

#       google.golang.org/genproto/googleapis/api v0.0.0-20230525234035-dd9d682886f9
# [1] git ls-remote https://github.com/googleapis/go-genproto dd9d682886f99d242574cd3eaea438ce7ea66399
SRCREV_api="dd9d682886f99d242574cd3eaea438ce7ea66399"
SRC_URI += "git://github.com/googleapis/go-genproto;name=api;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/google.golang.org/genproto/googleapis/api"

#       google.golang.org/genproto/googleapis/rpc v0.0.0-20230525234030-28d5490b6b19
# [1] git ls-remote https://github.com/googleapis/go-genproto 28d5490b6b19cce1ebbc6ab55ca8637bd35b3486
SRCREV_rpc="28d5490b6b19cce1ebbc6ab55ca8637bd35b3486"
SRC_URI += "git://github.com/googleapis/go-genproto;name=rpc;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/google.golang.org/genproto/googleapis/rpc"

#       github.com/docker/docker-credential-helpers v0.7.0
# [1] git ls-remote https://github.com/docker/docker-credential-helpers ac5992b5f4756fc0398a7d0c93c609e624368bde
SRCREV_docker-credential-helpers="ac5992b5f4756fc0398a7d0c93c609e624368bde"
SRC_URI += "git://github.com/docker/docker-credential-helpers;name=docker-credential-helpers;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/docker/docker-credential-helpers"

#       github.com/aws/aws-sdk-go-v2/service/ssooidc v1.14.5
# [1] git ls-remote https://github.com/aws/aws-sdk-go-v2 18bff5e44f4c2c140feaf54b2dd92140630c7e50
SRCREV_ssooidc="18bff5e44f4c2c140feaf54b2dd92140630c7e50"
SRC_URI += "git://github.com/aws/aws-sdk-go-v2;name=ssooidc;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/aws/aws-sdk-go-v2/service/ssooidc"

#       github.com/grpc-ecosystem/go-grpc-middleware v1.3.0
# [1] git ls-remote https://github.com/grpc-ecosystem/go-grpc-middleware df0f91b29bbbdfc3a686a7a8edbe2b9de2072fdd
SRCREV_go-grpc-middleware="df0f91b29bbbdfc3a686a7a8edbe2b9de2072fdd"
SRC_URI += "git://github.com/grpc-ecosystem/go-grpc-middleware;name=go-grpc-middleware;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/grpc-ecosystem/go-grpc-middleware"

#       github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.12.24
# [1] git ls-remote https://github.com/aws/aws-sdk-go-v2 18bff5e44f4c2c140feaf54b2dd92140630c7e50
SRCREV_imds="18bff5e44f4c2c140feaf54b2dd92140630c7e50"
SRC_URI += "git://github.com/aws/aws-sdk-go-v2;name=imds;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/aws/aws-sdk-go-v2/feature/ec2/imds"

#       github.com/matttproud/golang_protobuf_extensions v1.0.4
# [1] git ls-remote https://github.com/matttproud/golang_protobuf_extensions c182affec369e30f25d3eb8cd8a478dee585ae7d
SRCREV_golang_protobuf_extensions="c182affec369e30f25d3eb8cd8a478dee585ae7d"
SRC_URI += "git://github.com/matttproud/golang_protobuf_extensions;name=golang_protobuf_extensions;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/matttproud/golang_protobuf_extensions"

#       go.opentelemetry.io/otel/exporters/otlp/otlptrace v1.14.0
# [1] git ls-remote https://github.com/open-telemetry/opentelemetry-go 2e54fbb3fede5b54f316b3a08eab236febd854e0
SRCREV_otlptrace="2e54fbb3fede5b54f316b3a08eab236febd854e0"
SRC_URI += "git://github.com/open-telemetry/opentelemetry-go;name=otlptrace;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/go.opentelemetry.io/otel/exporters/otlp/otlptrace"

#       github.com/secure-systems-lab/go-securesystemslib v0.4.0
# [1] git ls-remote https://github.com/secure-systems-lab/go-securesystemslib abcd7c95c952df38eb237fab3764ef1b8d2b15c9
SRCREV_go-securesystemslib="abcd7c95c952df38eb237fab3764ef1b8d2b15c9"
SRC_URI += "git://github.com/secure-systems-lab/go-securesystemslib;name=go-securesystemslib;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/secure-systems-lab/go-securesystemslib"

#       github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.4.24
# [1] git ls-remote https://github.com/aws/aws-sdk-go-v2 18bff5e44f4c2c140feaf54b2dd92140630c7e50
SRCREV_endpoints-v2="18bff5e44f4c2c140feaf54b2dd92140630c7e50"
SRC_URI += "git://github.com/aws/aws-sdk-go-v2;name=endpoints-v2;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/aws/aws-sdk-go-v2/internal/endpoints/v2"

#       github.com/aws/aws-sdk-go-v2/internal/configsources v1.1.30
# [1] git ls-remote https://github.com/aws/aws-sdk-go-v2 18bff5e44f4c2c140feaf54b2dd92140630c7e50
SRCREV_configsources="18bff5e44f4c2c140feaf54b2dd92140630c7e50"
SRC_URI += "git://github.com/aws/aws-sdk-go-v2;name=configsources;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/aws/aws-sdk-go-v2/internal/configsources"

#       go.opentelemetry.io/otel/exporters/otlp/internal/retry v1.14.0
# [1] git ls-remote https://github.com/open-telemetry/opentelemetry-go 2e54fbb3fede5b54f316b3a08eab236febd854e0
SRCREV_retry="2e54fbb3fede5b54f316b3a08eab236febd854e0"
SRC_URI += "git://github.com/open-telemetry/opentelemetry-go;name=retry;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/go.opentelemetry.io/otel/exporters/otlp/internal/retry"

#       github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.9.24
# [1] git ls-remote https://github.com/aws/aws-sdk-go-v2 18bff5e44f4c2c140feaf54b2dd92140630c7e50
SRCREV_presigned-url="18bff5e44f4c2c140feaf54b2dd92140630c7e50"
SRC_URI += "git://github.com/aws/aws-sdk-go-v2;name=presigned-url;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/github.com/aws/aws-sdk-go-v2/service/internal/presigned-url"

#       go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.40.0
# [1] git ls-remote https://github.com/open-telemetry/opentelemetry-go-contrib 3311cc2a734d7597598cc67910f8f292d13eeda7
SRCREV_otelhttp="3311cc2a734d7597598cc67910f8f292d13eeda7"
SRC_URI += "git://github.com/open-telemetry/opentelemetry-go-contrib;name=otelhttp;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp"

#       go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc v1.14.0
# [1] git ls-remote https://github.com/open-telemetry/opentelemetry-go 2e54fbb3fede5b54f316b3a08eab236febd854e0
SRCREV_otlptracegrpc="2e54fbb3fede5b54f316b3a08eab236febd854e0"
SRC_URI += "git://github.com/open-telemetry/opentelemetry-go;name=otlptracegrpc;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc"

#       go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp v1.14.0
# [1] git ls-remote https://github.com/open-telemetry/opentelemetry-go 2e54fbb3fede5b54f316b3a08eab236febd854e0
SRCREV_otlptracehttp="2e54fbb3fede5b54f316b3a08eab236febd854e0"
SRC_URI += "git://github.com/open-telemetry/opentelemetry-go;name=otlptracehttp;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp"

#       go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.40.0
# [1] git ls-remote https://github.com/open-telemetry/opentelemetry-go-contrib 3311cc2a734d7597598cc67910f8f292d13eeda7
SRCREV_otelgrpc="3311cc2a734d7597598cc67910f8f292d13eeda7"
SRC_URI += "git://github.com/open-telemetry/opentelemetry-go-contrib;name=otelgrpc;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc"

#       go.opentelemetry.io/contrib/instrumentation/net/http/httptrace/otelhttptrace v0.40.0
# [1] git ls-remote https://github.com/open-telemetry/opentelemetry-go-contrib 3311cc2a734d7597598cc67910f8f292d13eeda7
SRCREV_otelhttptrace="3311cc2a734d7597598cc67910f8f292d13eeda7"
SRC_URI += "git://github.com/open-telemetry/opentelemetry-go-contrib;name=otelhttptrace;protocol=https;nobranch=1;destsuffix=${WORKDIR}/${BP}/src/import/vendor.fetch/go.opentelemetry.io/contrib/instrumentation/net/http/httptrace/otelhttptrace"

