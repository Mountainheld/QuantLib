
# makefile for ConvertibleBonds.cpp under Borland C++

.autodepend
#.silent

!ifdef _DEBUG
!ifndef _RTLDLL
    _D = -sd
!else
    _D = -d
!endif
!else
!ifndef _RTLDLL
    _D = -s
!endif
!endif

!ifdef __MT__
    _mt = -mt
!endif

# Directories
QL_INCLUDE_DIR      = "$(QL_DIR)"
QL_LIB_DIR          = "$(QL_DIR)\lib"
EXE_DIR            = .\bin

# Options
CC_OPTS = -vi- -I$(QL_INCLUDE_DIR) -w-8070

!ifdef _DEBUG
    CC_OPTS = $(CC_OPTS) -v -D_DEBUG
!else
    CC_OPTS = $(CC_OPTS) -O2 -DNDEBUG
!endif

!ifdef __MT__
    CC_OPTS = $(CC_OPTS) -tWM
!endif

!ifdef _RTLDLL
    CC_OPTS = $(CC_OPTS) -D_RTLDLL
!endif

!ifdef SAFE
    CC_OPTS = $(CC_OPTS) -DQL_EXTRA_SAFETY_CHECKS
!endif

# Primary target:
$(EXE_DIR)\ConvertibleBonds-bcb$(_mt)$(_D).exe: $(EXE_DIR) ConvertibleBonds.cpp
    if exist $(EXE_DIR)\ConvertibleBonds-bcb$(_mt)$(_D).exe \
         del $(EXE_DIR)\ConvertibleBonds-bcb$(_mt)$(_D).exe
    bcc32 $(CC_OPTS) -L$(QL_LIB_DIR) \
    -o"ConvertibleBonds$(_mt)$(_D).obj" \
    -e"$(EXE_DIR)\ConvertibleBonds-bcb$(_mt)$(_D).exe" \
    ConvertibleBonds.cpp

$(EXE_DIR):
    if not exist .\bin md .\bin

# Clean up
clean::
    if exist *.obj*  del /q *.obj*
    if exist $(EXE_DIR)\*.tds   del /q $(EXE_DIR)\*.tds
    if exist $(EXE_DIR)\ConvertibleBonds-bcb$(_mt)$(_D).exe \
         del $(EXE_DIR)\ConvertibleBonds-bcb$(_mt)$(_D).exe
