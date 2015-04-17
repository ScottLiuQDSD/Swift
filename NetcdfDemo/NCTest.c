//
//  NCTest.c
//  NetcdfDemo
//
//  Created by 刘玉龙 on 15/3/3.
//  Copyright (c) 2015年 刘玉龙. All rights reserved.
//

#include "NCTest.h"
#include "netcdf.h"
void  findNC()
{
    int ncid = 0;
    size_t size = 1;
    const char *name = "NULL";
    nc_type *typeidp = 0;
    nc_def_compound(ncid, size, name, typeidp);
}