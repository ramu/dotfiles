#----------------------------------
# vcs-log
function log () {
   if [[ $vcs_info_msg_0_ = *git* ]]; then
      gl
   elif [[ $vcs_info_msg_0_ = *svn* ]]; then
      svn log
   else
      echo "unknown vcs"
   fi
}

#----------------------------------
# vcs-add
function add () {
   if [[ $vcs_info_msg_0_ == *git* ]]; then
      ga $@
   elif [[ $vcs_info_msg_0_ == *svn* ]]; then
      svn add $@
   else
      echo "unknown vcs"
   fi
}

