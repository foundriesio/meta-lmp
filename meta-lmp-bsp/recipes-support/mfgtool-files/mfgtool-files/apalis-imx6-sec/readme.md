# How to enable secure boot for apalis-imx6

Download and extract CST from nxp.com.

Start exporting the needed variable

   export CST_PATH=/path_to_cst/cst-3.3.1/linux64/bin/cst
   export SPL_PATH=/path_to_spl/
   export KEY_PATH=/path_to_key/


Download the `lmp-tools`

   git clone lmp-tools
   cd lmp-tools/security/imx_hab4


Sign the MfgTool SPL file

   ./sign-file.sh --key-dir $KEY_PATH --cst $CST_PATH --spl $SPL_PATH/mfgtool-files-apalis-imx6-sec/SPL-mfgtool

Sign the SPL file

   ./sign-file.sh --key-dir $KEY_PATH --cst $CST_PATH --spl $SPL_PATH/SPL-apalis-imx6-sec

Fuse the key to the board

   cd $SPL_PATH
   sudo ./mfgtool-files-apalis-imx6-sec/uuu -pp 1 ./mfgtool-files-apalis-imx6-sec/fuse.uuu

Close the board

   sudo ./mfgtool-files-apalis-imx6-sec/uuu -pp 1 ./mfgtool-files-apalis-imx6-sec/close.uuu

Flash the system to the board

   sudo ./mfgtool-files-apalis-imx6-sec/uuu -pp 1 ./mfgtool-files-apalis-imx6-sec/full_image.uuu
