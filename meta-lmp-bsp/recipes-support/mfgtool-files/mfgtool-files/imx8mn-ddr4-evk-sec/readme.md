# How to enable secure boot for imx8mn-ddr4-evk

Download and extract CST from nxp.com: https://www.nxp.com/webapp/sps/download/license.jsp?colCode=IMX_CST_TOOL_NEW&appType=file2&location=null&DOWNLOAD_ID=null

Start exporting the needed variables

   export CST_PATH=/path_to_cst/cst-3.3.1/linux64/bin/cst
   export SPL_PATH=/path_to_spl/
   export KEY_PATH=/path_to_key/

Download the `lmp-tools`

   git clone https://github.com/foundriesio/lmp-tools.git
   cd lmp-tools/security/imx_hab4

Sign the MFGTool SPL file

   ./sign-file.sh --key-dir $KEY_PATH --cst $CST_PATH --spl $SPL_PATH/mfgtool-files-imx8mn-ddr4-evk-sec/imx-boot-mfgtool

Sign the SPL file

   ./sign-file.sh --key-dir $KEY_PATH --cst $CST_PATH --spl $SPL_PATH/imx-boot-imx8mn-ddr4-evk-sec

Fuse the key to the board

   cd $SPL_PATH
   sudo ./mfgtool-files-imx8mn-ddr4-evk-sec/uuu -pp 1 ./mfgtool-files-imx8mn-ddr4-evk-sec/fuse.uuu

Close the board

   sudo ./mfgtool-files-imx8mn-ddr4-evk-sec/uuu -pp 1 ./mfgtool-files-imx8mn-ddr4-evk-sec/close.uuu

Flash the system to the board

   sudo ./mfgtool-files-imx8mn-ddr4-evk-sec/uuu -pp 1 ./mfgtool-files-imx8mn-ddr4-evk-sec/full_image.uuu
