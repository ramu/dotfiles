#----------------------------------
# vcs-log
function log () {
   if [[ $vcs_info_msg_0_ = *git* ]]; then
      gl
   elif [[ $vcs_info_msg_0_ = *bzr* ]]; then
      bzr log
   elif [[ $vcs_info_msg_0_ = *hg* ]]; then
      hl
   elif [[ $vcs_info_msg_0_ = *svn* ]]; then
      svn log
   else
      echo "unknown vcs"
   fi
}

function newlog () {
   array=("gl" "bzr log" "hl" "svn log")
   `${array[1]}`
}

#----------------------------------
# vcs-add
function add () {
   if [[ $vcs_info_msg_0_ == *git* ]]; then
      ga $@
   elif [[ $vcs_info_msg_0_ == *bzr* ]]; then
      bzr add $@
   elif [[ $vcs_info_msg_0_ == *hg* ]]; then
      ha $@
   elif [[ $vcs_info_msg_0_ == *svn* ]]; then
      svn add $@
   else
      echo "unknown vcs"
   fi
}

