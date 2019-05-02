<template>
    <div>
      <el-row id="tt">
        <el-col :span="18">

          <el-breadcrumb class="bread" separator="/">
                        <el-breadcrumb-item><i class="el-icon-menu"></i>实验地描述可以只填写部分信息，支持模糊查询</el-breadcrumb-item>
                        <el-breadcrumb-item>设备描述可以只填写部分信息，支持模糊查询,支持多项（用逗号隔开）</el-breadcrumb-item>
            </el-breadcrumb>
       

        </el-col>
      </el-row>
      
 <el-row class="cardstyle" :gutter="5" >
   <el-col :span="12">

     <el-card style="height:500px;">

  <el-form ref="form" :model="form" label-width="100px" >
    
    <el-row :gutter="20">
      <el-col :span="4">
        <el-tooltip content="请选择数据类型" placement="bottom" >
        <el-form-item label="数据类型">
        </el-form-item>
        </el-tooltip>
      </el-col>
      <el-col :span="4">
          <el-select v-model="form.datatype" >
          <el-option label="ctd_rbr" value="ctd_rbr"></el-option>
          </el-select>
  
      </el-col>
         
    </el-row>


  <el-row :gutter="20">
    <el-col :span="4">
      <el-tooltip content="请填写试验地描述" placement="bottom" >
      <el-form-item label="实验地描述">
    
      </el-form-item> 
       </el-tooltip>
    </el-col>
    <el-col :span="4">
      <el-tooltip content="可以只填写部分信息，支持模糊查询" placement="bottom" >
      <el-input v-model="form.experimentlocation" ></el-input>
      </el-tooltip>
    </el-col>
    
  </el-row>
  <el-row>
    <el-col :span="4">

        <el-tooltip content="请填写设备描述" placement="bottom" >
          <el-form-item label="设备描述">
    
            </el-form-item>
        </el-tooltip>
      

    </el-col>
    <el-col :span="4">
       <el-tooltip content="可以只填写部分信息，支持模糊查询,支持多项（用逗号隔开）" placement="bottom" >
       <el-input v-model="form.devicename" placeholder="可以只填写部分信息，支持模糊查询,支持多项（用逗号隔开）"></el-input>
       </el-tooltip>
    </el-col>
 
  </el-row>
  <el-row :gutter="20">

       <el-tooltip content="请输入开始/结束时间" placement="bottom" >
            <el-col :span="4"> 
                  <el-form-item label="开始/结束时间">
                  </el-form-item>
            </el-col>
        </el-tooltip>
  
    <el-col :span="7">
      <el-date-picker v-model="form.collectstarttime"
      type="datetime"
      value-format="yyyy-MM-dd HH:mm:ss"
            format="yyyy-MM-dd HH:mm:ss"

      placeholder="选择开始日期时间"
      align="right"
      :picker-options="pickerOptions1"></el-date-picker>
    </el-col>


  
    <el-col :span="7">
      <el-date-picker v-model="form.collectendtime"
      type="datetime"
      value-format="yyyy-MM-dd HH:mm:ss"
            format="yyyy-MM-dd HH:mm:ss"
      placeholder="选择结束日期时间"
      align="right"
      :picker-options="pickerOptions2"></el-date-picker>
    </el-col>

  
  </el-row>

  <el-row :gutter="10">
      <el-col :span="4">
        <el-tooltip content="请输入经度" placement="bottom" >
            <el-form-item label="经度">
              
            </el-form-item>
        </el-tooltip>
      </el-col>


       <el-col :span="4">
         <el-input v-model="form.gpslongtitude" placeholder="请输入经度"></el-input>
      </el-col>   


     <el-col :span="4">
       <el-tooltip content="请输入纬度" placement="bottom" >
         <el-form-item label="纬度">
              
          </el-form-item>
       </el-tooltip>
      </el-col>
            
      <el-col :span="4"> 
           <el-input v-model="form.gpslatitude" placeholder="请输入纬度"></el-input>
      </el-col>
         
            

  </el-row>

     <el-button type="primary" @click="onSubmit">立即查询</el-button>
 
  </el-form>
  </el-card>
   </el-col>


   <el-col :span="12">
      <div class="wafpic_c">
           <el-card >
             <div style="height:50px">
            图像形式:
            
            <el-col>
         
               <el-select v-model="fflag"  >
                 <el-option
                  v-for="item in options"
                 :key="item.value"
                 :label="item.label"
                 :value="item.value"
                 :fflag="item.fflag"
                 @click.native="showtable(value)"
                 >
                 </el-option>
             </el-select>
             <el-button type="primary" @click="drawpic">画图</el-button>
            </el-col>
           <div v-if="fflag==1">
             <el-col>
               
                <el-checkbox  v-model="mmax">max</el-checkbox>
                <el-checkbox  v-model="mmin">min</el-checkbox>
                <el-checkbox  v-model="mave">ave</el-checkbox>
                
             
            </el-col>
           </div>
            
             
              
             </div>
              <div id="waf1" style="height:408px;"></div>
             </el-card>
        </div>
    </el-col>
   
 </el-row>
 
 <el-row>



   <el-card>
  <el-table
      :data="tableData.slice((currpage - 1) * pagesize, currpage * pagesize)" 
      style="width: 100%">
      <el-table-column
      type="index"
      :index="indexMethod">
    </el-table-column>
    <!-- <div vi-if="fflag！='请选择'">  -->

    
      <el-table-column
        prop="device_id"
        label="device_id"
        width="180">
      </el-table-column>
      <el-table-column
        prop="experiment_id"
        label="experiment_id"
        width="180">
      </el-table-column>
      <el-table-column
        prop="temperature"
        label="温度"
        width="180">
      </el-table-column>
      <el-table-column
        prop="depth"
        label="深度"
        width="180">
      </el-table-column>
        <el-table-column
        prop="salinity"
        label="盐度"
        width="180">
      </el-table-column>
        <el-table-column
        prop="sound"
        label="sound"
        width="180">
      </el-table-column>
        <el-table-column
        prop="gps_longitude"
        label="经度"
        width="180">
      </el-table-column>
        <el-table-column
        prop="gps_latitude"
        label="纬度"
        width="150">
      </el-table-column>
       <el-table-column
        prop="collection_time"
        label="采样时间"
        width="150">
      </el-table-column>
      <!-- </div>  -->
    </el-table>
<el-pagination background 
			layout="prev, pager, next, sizes, total, jumper"
			:page-sizes="[5, 10, 15, 20]"
			:page-size="pagesize"
			:total="this.tableData.length"
			@current-change="handleCurrentChange" 
			@size-change="handleSizeChange" 
			>
		</el-pagination>


</el-card>
 </el-row>

<!-- <h1>{{tableData}}</h1> 测试-->
    </div>
   
</template>

<script>
import axios from "axios"
import echarts from "echarts";
  export default {
    data() {
      return {

            
            tem:[],
            dep:[],
            sal:[],
            sou:[],
            time:[],
            fflag:"请选择", // 图像样式 
            fflag1: 0,     // 1:最大值 2：最小值 3：平均值 4：max和min
                           // 5：max ave 6:min ave 7:max min ave 


            mmax:true, //多选框值绑定
            mmin:true, //
            mave:true, //



             myChart1: "",
             tableData: [],
             
             pagesize: 10,
             currpage: 1,
              options: [
                      {
                        value: "1",
                        label: "时间为x轴",
                        fflag:1
                      },
                      {
                        value: "2",
                        label: "温度/深度",
                        fflag:2
                      },
                      {
                        value: "3",
                        label: "温度/盐度",
                        fflag:3
                      },
                      {
                        value: "4",
                        label: "温度/声音",
                        fflag:4
                      },
                      {
                        value: "5",
                        label: "深度/盐度",
                        fflag:5
                      },
                      {
                        value: "6",
                        label: "深度/声音",
                        fflag:6
                      },
                       {
                        value: "7",
                        label: "盐度/声音",
                        fflag:7
                      }
                      ],
          pickerOptions1: {
          shortcuts: [{
            text: '今天',
            onClick(picker) {
              picker.$emit('pick', new Date());
            }
          }, {
            text: '昨天',
            onClick(picker) {
              const date = new Date();
              date.setTime(date.getTime() - 3600 * 1000 * 24);
              picker.$emit('pick', date);
            }
          }, {
            text: '一周前',
            onClick(picker) {
              const date = new Date();
              date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
              picker.$emit('pick', date);
            }
          }]
        },
         pickerOptions2: {
          shortcuts: [{
            text: '今天',
            onClick(picker) {
              picker.$emit('pick', new Date());
            }
          }, {
            text: '昨天',
            onClick(picker) {
              const date = new Date();
              date.setTime(date.getTime() - 3600 * 1000 * 24);
              picker.$emit('pick', date);
            }
          }, {
            text: '一周前',
            onClick(picker) {
              const date = new Date();
              date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
              picker.$emit('pick', date);
            }
          }]
        },
        form: {
          operatetype: 'getdatafromdb',
          datatype:'ctd_rbr',
          experimentlocation: "eastsea",  //用户添加实验地址描述信息,可以只填写部分信息，支持模糊查询
          devicename: "rbr",             //用户添加设备名称描述信息,可以只填写部分信息，支持模糊查询,支持多项（用逗号隔开）
          collectstarttime: "",
          collectendtime:   "",
          gpslongtitude: "",           //用户添加 经度信息
          gpslatitude: "",             //用户添加 维度信息 
          // type: 'gdfdb',
          // datatype:'ctdtob',
          // sea: '东海',
          // date1: "2016-10-20 08:58:46",
          // date2: "2016-10-20 08:58:50",
          // batch:'[1]',
        }
      }
    },
    methods: {
      onSubmit() {
          let self=this
          let param=new FormData()
          param.append('operatetype',self.form.operatetype)
          param.append('datatype',self.form.datatype)
          param.append('experimentlocation',self.form.experimentlocation)
          param.append('devicename',self.form.devicename)
          param.append('collectstarttime',self.form.collectstarttime)
          param.append('collectendtime',self.form.collectendtime)
          param.append('gpslongtitude',self.form.gpslongtitude)
          param.append('gpslatitude',self.form.gpslatitude)
         


         console.log(self.form.operatetype)
         console.log(self.form.gpslongtitude)
         console.log(param.gpslongtitude)
        axios
        .post("/apis/datamanage/gdfdb/",param ).then(res=>{
          
          console.log(res)
          self.tableData=res.data.data 
         
          if(res.data.addition=="Data Get Succeed!"&&self.fflag!="请选择")
           {  
            self.$message({
              message:'数据读取成功',
              type:'success'
            
            }  )
             console.log(self.tableData.length)

              for(var i=0;i<self.tableData.length;i++)
              {
                var dicc=[];
                var flag=0;
                dicc=self.tableData[i];
                for(var j=0;j<self.tableData.length;j++)
                {
                  if(self.time[j]==dicc['collection_time'])
                  {
                     flag=1; 
                  }
                     
                }
                if(flag==0)
                {
                      self.dep.push(dicc['depth']);
                      self.tem.push(dicc['temperature']);
                      self.sal.push(dicc['salinity']);
                      self.sou.push(dicc['sound']);
                      self.time.push(dicc['collection_time']);
                  
                }
                     

              }


              //  var dic1=[];
              //  dic1=self.tableData[0];
              //  var dic2=[]
              //  dic2=self.tableData[1];
              //  self.xdata.push(dic1['depth'])
              //  self.xdata.push(dic2['depth'])
              
               console.log(self.tableData[0])
               console.log(self.dep)
               console.log(self.tem)
               console.log(self.time)
              //  for(var i=0;i<tableData.length;i++){
              //   for(var dic[i]=tableData[i])
              //   {

              //   }
              //  }
                        this.initcheck(),
                        this.init2(self.tem,self.dep,self.sal,
                        self.sou,self.time,self.fflag,self.fflag1),
     
                          (window.onresize = () => {
                      // 这里使用箭头函数，避免this指向问题
                      this.myChart1.resize();
                    
                    });
           }
          else if(res.data.addition=="Data Get Succeed!"&&self.fflag=="请选择")
          {
           self.$message.error('请选择图像格式')
          
          }
           else
           {
                self.$message({
                  message:'读取失败/暂无数据',
                  type:'warning'
                })
               
           }    

          
        })
      },
       indexMethod(index) {
        return index +1+ (this.currpage-1) * this.pagesize;
      },
      handleCurrentChange(cpage) {
					this.currpage = cpage;
				},
				handleSizeChange(psize) {
					this.pagesize = psize;
        },
       drawpic()//和画图按钮绑定在一起
       { 
     
        this.initcheck();
        
   
        this.init2(this.tem,this.dep,this.sal,
                        this.sou,this.time,this.fflag,this.fflag1)
       },
       initcheck()//判断多选框的选值
       {

          if(this.mmax==true&&this.mmin==false&&this.mave==false)
          {
              this.fflag1=1;
           
            
          }
          else if(this.mmax==false&&this.mmin==true&&this.mave==false)
          {
            this.fflag1=2;
          }
          else if(this.mmax==false&&this.mmin==false&&this.mave==true)
          {
             this.fflag1=3;
             
          }
          else if(this.mmax==true&&this.mmin==true&&this.mave==false)
          {
              this.fflag1=4;
             
          }
          else if(this.mmax==true&&this.mmin==false&&this.mave==true)
          {
             this.fflag1=5;
          
          }
          else if(this.mmax==false&&this.mmin==true&&this.mave==true)
          {
              this.fflag1=6;
            
          }
          else if(this.mmax==true&&this.mmin==true&&this.mave==true)
          { 
             this.fflag1=7;
            
          }
          else 
          {
              this.fflag1=0;
           
          }
         
       },
        init2(tem,dep,sal,sou,time,fflag,fflag1)
     {
      this.myChart1 = echarts.init(document.getElementById("waf1"));
      if(fflag==1)//以时间为x轴
        {
          if(fflag1==7)
          {
          var option = {
                title: {
                        text: '以时间为x轴'
                       },
                tooltip: {
                    trigger: 'axis'
                          },
                 legend: {
                        data:['温度','深度','盐度','声音']
                         },
                 grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                         },
                toolbox: {
                          show:true,
                              feature: {
                               saveAsImage: {},
                               dataZoom: {
                                     yAxisIndex: 'none'
                                        },     //区域缩放，区域缩放还原
                               dataView: { 
                                     readOnly: false
                                          }, //数据视图
                               magicType: {
                                     type: ['line', 'bar']
                                           },  //切换为折线图，切换为柱状图
                               restore: {},  //还原
              }
          },
              xAxis: {
                  type: 'category',
                  boundaryGap: false,
                  data: time
              },
              yAxis: {
                  type: 'value'
              },
              series: [

                 {
                      name:'温度',
                      type:'line',
                      data: tem,
                       markPoint: {
                          data: [
                            
                              {type: 'max', name: '最大值'},
                              {type: 'min', name: '最小值'}
                          ]
                      },
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值' }
                          ]
                      }
                 },
                 
                  {
                      name:'深度',
                      type:'line',
                    
                      data:dep,
                       markPoint: {
                          data: [
                              {type: 'max', name: '最大值'},
                              {type: 'min', name: '最小值'}
                          ]
                      },
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值'}
                          ]
                      }
                      
                  },
                  {
                      name:'盐度',
                      type:'line',
                    
                      data:sal,
                       markPoint: {
                          data: [
                              {type: 'max', name: '最大值'},
                              {type: 'min', name: '最小值'}
                          ]
                      },
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值'}
                          ]
                      }
                  },
                  {
                      name:'声音',
                      type:'line',
                    
                      data:sou,
                       markPoint: {
                          data: [
                              {type: 'max', name: '最大值'},
                              {type: 'min', name: '最小值'}
                          ]
                      },
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值'}
                          ]
                      }
                  },
                  
              ]
          }
          };
          if(fflag1==6)
          {
                 var option = {
                title: {
                        text: '以时间为x轴'
                       },
                tooltip: {
                    trigger: 'axis'
                          },
                 legend: {
                        data:['温度','深度','盐度','声音']
                         },
                 grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                         },
                toolbox: {
                          show:true,
                              feature: {
                               saveAsImage: {},
                               dataZoom: {
                                     yAxisIndex: 'none'
                                        },     //区域缩放，区域缩放还原
                               dataView: { 
                                     readOnly: false
                                          }, //数据视图
                               magicType: {
                                     type: ['line', 'bar']
                                           },  //切换为折线图，切换为柱状图
                               restore: {},  //还原
              }
          },
              xAxis: {
                  type: 'category',
                  boundaryGap: false,
                  data: time
              },
              yAxis: {
                  type: 'value'
              },
              series: [

                 {
                      name:'温度',
                      type:'line',
                      data: tem,
                       markPoint: {
                          data: [
                            
                            
                              {type: 'min', name: '最小值'}
                          ]
                      },
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值' }
                          ]
                      }
                 },
                 
                  {
                      name:'深度',
                      type:'line',
                    
                      data:dep,
                       markPoint: {
                          data: [
                            
                              {type: 'min', name: '最小值'}
                          ]
                      },
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值'}
                          ]
                      }
                      
                  },
                  {
                      name:'盐度',
                      type:'line',
                    
                      data:sal,
                       markPoint: {
                          data: [
                           
                              {type: 'min', name: '最小值'}
                          ]
                      },
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值'}
                          ]
                      }
                  },
                  {
                      name:'声音',
                      type:'line',
                    
                      data:sou,
                       markPoint: {
                          data: [
                              
                              {type: 'min', name: '最小值'}
                          ]
                      },
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值'}
                          ]
                      }
                  },
                  
              ]
          }
          };
          if(fflag1==5)
          {
                 var option = {
                title: {
                        text: '以时间为x轴'
                       },
                tooltip: {
                    trigger: 'axis'
                          },
                 legend: {
                        data:['温度','深度','盐度','声音']
                         },
                 grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                         },
                toolbox: {
                          show:true,
                              feature: {
                               saveAsImage: {},
                               dataZoom: {
                                     yAxisIndex: 'none'
                                        },     //区域缩放，区域缩放还原
                               dataView: { 
                                     readOnly: false
                                          }, //数据视图
                               magicType: {
                                     type: ['line', 'bar']
                                           },  //切换为折线图，切换为柱状图
                               restore: {},  //还原
              }
          },
              xAxis: {
                  type: 'category',
                  boundaryGap: false,
                  data: time
              },
              yAxis: {
                  type: 'value'
              },
              series: [

                 {
                      name:'温度',
                      type:'line',
                      data: tem,
                       markPoint: {
                          data: [
                            
                              {type: 'max', name: '最大值'},
                             
                          ]
                      },
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值' }
                          ]
                      }
                 },
                 
                  {
                      name:'深度',
                      type:'line',
                    
                      data:dep,
                       markPoint: {
                          data: [
                              {type: 'max', name: '最大值'},
                             
                          ]
                      },
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值'}
                          ]
                      }
                      
                  },
                  {
                      name:'盐度',
                      type:'line',
                    
                      data:sal,
                       markPoint: {
                          data: [
                              {type: 'max', name: '最大值'},
                             
                          ]
                      },
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值'}
                          ]
                      }
                  },
                  {
                      name:'声音',
                      type:'line',
                    
                      data:sou,
                       markPoint: {
                          data: [
                              {type: 'max', name: '最大值'},
                              
                          ]
                      },
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值'}
                          ]
                      }
                  },
                  
              ]
          }
          };
          if(fflag1==4)
          { 
               var option = {
                title: {
                        text: '以时间为x轴'
                       },
                tooltip: {
                    trigger: 'axis'
                          },
                 legend: {
                        data:['温度','深度','盐度','声音']
                         },
                 grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                         },
                toolbox: {
                          show:true,
                              feature: {
                               saveAsImage: {},
                               dataZoom: {
                                     yAxisIndex: 'none'
                                        },     //区域缩放，区域缩放还原
                               dataView: { 
                                     readOnly: false
                                          }, //数据视图
                               magicType: {
                                     type: ['line', 'bar']
                                           },  //切换为折线图，切换为柱状图
                               restore: {},  //还原
              }
          },
              xAxis: {
                  type: 'category',
                  boundaryGap: false,
                  data: time
              },
              yAxis: {
                  type: 'value'
              },
              series: [

                 {
                      name:'温度',
                      type:'line',
                      data: tem,
                       markPoint: {
                          data: [
                            
                              {type: 'max', name: '最大值'},
                              {type: 'min', name: '最小值'}
                          ]
                      },
                     
                 },
                 
                  {
                      name:'深度',
                      type:'line',
                    
                      data:dep,
                       markPoint: {
                          data: [
                              {type: 'max', name: '最大值'},
                              {type: 'min', name: '最小值'}
                          ]
                      },
                     
                      
                  },
                  {
                      name:'盐度',
                      type:'line',
                    
                      data:sal,
                       markPoint: {
                          data: [
                              {type: 'max', name: '最大值'},
                              {type: 'min', name: '最小值'}
                          ]
                      },
                     
                  },
                  {
                      name:'声音',
                      type:'line',
                    
                      data:sou,
                       markPoint: {
                          data: [
                              {type: 'max', name: '最大值'},
                              {type: 'min', name: '最小值'}
                          ]
                      },
                     
                  },
                  
              ]
          }
          };
          if(fflag1==3)
          {
               var option = {
                title: {
                        text: '以时间为x轴'
                       },
                tooltip: {
                    trigger: 'axis'
                          },
                 legend: {
                        data:['温度','深度','盐度','声音']
                         },
                 grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                         },
                toolbox: {
                          show:true,
                              feature: {
                               saveAsImage: {},
                               dataZoom: {
                                     yAxisIndex: 'none'
                                        },     //区域缩放，区域缩放还原
                               dataView: { 
                                     readOnly: false
                                          }, //数据视图
                               magicType: {
                                     type: ['line', 'bar']
                                           },  //切换为折线图，切换为柱状图
                               restore: {},  //还原
              }
          },
              xAxis: {
                  type: 'category',
                  boundaryGap: false,
                  data: time
              },
              yAxis: {
                  type: 'value'
              },
              series: [

                 {
                      name:'温度',
                      type:'line',
                      data: tem,
                       
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值' }
                          ]
                      }
                 },
                 
                  {
                      name:'深度',
                      type:'line',
                    
                      data:dep,
                      
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值'}
                          ]
                      }
                      
                  },
                  {
                      name:'盐度',
                      type:'line',
                    
                      data:sal,
                      
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值'}
                          ]
                      }
                  },
                  {
                      name:'声音',
                      type:'line',
                    
                      data:sou,
                      
                      markLine: {
                          data: [
                              {type: 'average', name: '平均值'}
                          ]
                      }
                  },
                  
              ]
          }
          };
          if(fflag1==2)
          {
                 var option = {
                title: {
                        text: '以时间为x轴'
                       },
                tooltip: {
                    trigger: 'axis'
                          },
                 legend: {
                        data:['温度','深度','盐度','声音']
                         },
                 grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                         },
                toolbox: {
                          show:true,
                              feature: {
                               saveAsImage: {},
                               dataZoom: {
                                     yAxisIndex: 'none'
                                        },     //区域缩放，区域缩放还原
                               dataView: { 
                                     readOnly: false
                                          }, //数据视图
                               magicType: {
                                     type: ['line', 'bar']
                                           },  //切换为折线图，切换为柱状图
                               restore: {},  //还原
              }
          },
              xAxis: {
                  type: 'category',
                  boundaryGap: false,
                  data: time
              },
              yAxis: {
                  type: 'value'
              },
              series: [

                 {
                      name:'温度',
                      type:'line',
                      data: tem,
                       markPoint: {
                          data: [
                            
                           
                              {type: 'min', name: '最小值'}
                          ]
                      },
                      
                 },
                 
                  {
                      name:'深度',
                      type:'line',
                    
                      data:dep,
                       markPoint: {
                          data: [
                      
                              {type: 'min', name: '最小值'}
                          ]
                      },
                      
                      
                  },
                  {
                      name:'盐度',
                      type:'line',
                    
                      data:sal,
                       markPoint: {
                          data: [
                             
                              {type: 'min', name: '最小值'}
                          ]
                      },
                     
                  },
                  {
                      name:'声音',
                      type:'line',
                    
                      data:sou,
                       markPoint: {
                          data: [
                              
                              {type: 'min', name: '最小值'}
                          ]
                      },
                    
                  },
                  
              ]
          }
          };
          if(fflag1==1)
          {
               var option = {
                title: {
                        text: '以时间为x轴'
                       },
                tooltip: {
                    trigger: 'axis'
                          },
                 legend: {
                        data:['温度','深度','盐度','声音']
                         },
                 grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                         },
                toolbox: {
                          show:true,
                              feature: {
                               saveAsImage: {},
                               dataZoom: {
                                     yAxisIndex: 'none'
                                        },     //区域缩放，区域缩放还原
                               dataView: { 
                                     readOnly: false
                                          }, //数据视图
                               magicType: {
                                     type: ['line', 'bar']
                                           },  //切换为折线图，切换为柱状图
                               restore: {},  //还原
              }
          },
              xAxis: {
                  type: 'category',
                  boundaryGap: false,
                  data: time
              },
              yAxis: {
                  type: 'value'
              },
              series: [

                 {
                      name:'温度',
                      type:'line',
                      data: tem,
                       markPoint: {
                          data: [
                            
                              {type: 'max', name: '最大值'},
                            
                          ]
                      },
                      
                 },
                 
                  {
                      name:'深度',
                      type:'line',
                    
                      data:dep,
                       markPoint: {
                          data: [
                              {type: 'max', name: '最大值'},
                       
                          ]
                      },
                     
                      
                  },
                  {
                      name:'盐度',
                      type:'line',
                    
                      data:sal,
                       markPoint: {
                          data: [
                              {type: 'max', name: '最大值'},
                           
                          ]
                      },
                     
                  },
                  {
                      name:'声音',
                      type:'line',
                    
                      data:sou,
                       markPoint: {
                          data: [
                              {type: 'max', name: '最大值'},
                             
                          ]
                      },
                     
                  },
                  
              ]
          }
          };
          if(fflag1==0)
          {
                   var option = {
                title: {
                        text: '以时间为x轴'
                       },
                tooltip: {
                    trigger: 'axis'
                          },
                 legend: {
                        data:['温度','深度','盐度','声音']
                         },
                 grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                         },
                toolbox: {
                          show:true,
                              feature: {
                               saveAsImage: {},
                               dataZoom: {
                                     yAxisIndex: 'none'
                                        },     //区域缩放，区域缩放还原
                               dataView: { 
                                     readOnly: false
                                          }, //数据视图
                               magicType: {
                                     type: ['line', 'bar']
                                           },  //切换为折线图，切换为柱状图
                               restore: {},  //还原
              }
          },
              xAxis: {
                  type: 'category',
                  boundaryGap: false,
                  data: time
              },
              yAxis: {
                  type: 'value'
              },
              series: [

                 {
                      name:'温度',
                      type:'line',
                      data: tem,
                    
                      
                 },
                 
                  {
                      name:'深度',
                      type:'line',
                    
                      data:dep,
                      
                     
                      
                  },
                  {
                      name:'盐度',
                      type:'line',
                    
                      data:sal,
                       
                     
                  },
                  {
                      name:'声音',
                      type:'line',
                    
                      data:sou,
                      
                  },
                  
              ]
          } 
          };
         
      };
      if(fflag==2)
      {
          var option = {
            title: {
            text: '温度/深度'
               },
          tooltip: {
              trigger: 'axis'
          },
          
          grid: {
              left: '3%',
              right: '4%',
              bottom: '3%',
              containLabel: true
          },
          toolbox: {
            show:true,
              feature: {
                  saveAsImage: {},

              }
          },
              xAxis: {
                  type: 'category',
                  data: tem,
                  
                  axisLabel:{
                    formatter:'{value} °C'
                  }
              },
              yAxis: {
                  type: 'value',
                  data:dep,
              },
              series: [
                 
                  {
                      name:'深度',
                      type:'line',
                      data:dep
                  },
                 
                  
              ]
          }
      };
      if(fflag==3)
      {
          var option = {
            title: {
            text: '温度/盐度'
               },
          tooltip: {
              trigger: 'axis'
          },
          
          grid: {
              left: '3%',
              right: '4%',
              bottom: '3%',
              containLabel: true
          },
          toolbox: {
            show:true,
              feature: {
                  saveAsImage: {},

              }
          },
              xAxis: {
                  type: 'category',
                  data: tem,
                  
                  axisLabel:{
                    formatter:'{value} °C'
                  }
              },
              yAxis: {
                  type: 'value',
                  data:sal,
              },
              series: [
                 
                  {
                      name:'盐度',
                      type:'line',
                      data:sal
                  },
                 
                  
              ]
          }
      };
      if(fflag==4)
      {
          var option = {
            title: {
            text: '温度/声音'
               },
          tooltip: {
              trigger: 'axis'
          },
          
          grid: {
              left: '3%',
              right: '4%',
              bottom: '3%',
              containLabel: true
          },
          toolbox: {
            show:true,
              feature: {
                  saveAsImage: {},

              }
          },
              xAxis: {
                  type: 'category',
                  data: tem,
                  
                  axisLabel:{
                    formatter:'{value} °C'
                  }
              },
              yAxis: {
                  type: 'value',
                  data:sou,
              },
              series: [
                 
                  {
                      name:'声音',
                      type:'line',
                      data:sou
                  },
                 
                  
              ]
          }
      };
      if(fflag==5)
      {
          var option = {
            title: {
            text: '深度/盐度'
               },
          tooltip: {
              trigger: 'axis'
          },
          
          grid: {
              left: '3%',
              right: '4%',
              bottom: '3%',
              containLabel: true
          },
          toolbox: {
            show:true,
              feature: {
                  saveAsImage: {},

              }
          },
              xAxis: {
                  type: 'category',
                  data: dep,
                  
                  axisLabel:{
                    formatter:'{value} m'
                  }
              },
              yAxis: {
                  type: 'value',
                  data:sal,
              },
              series: [
                 
                  {
                      name:'盐度',
                      type:'line',
                      data:sal
                  },
                 
                  
              ]
          }
      };
      if(fflag==6)
      {
          var option = {
            title: {
            text: '深度/声音'
               },
          tooltip: {
              trigger: 'axis'
          },
          
          grid: {
              left: '3%',
              right: '4%',
              bottom: '3%',
              containLabel: true
          },
          toolbox: {
            show:true,
              feature: {
                  saveAsImage: {},

              }
          },
              xAxis: {
                  type: 'category',
                  data: dep,
                  
                  axisLabel:{
                    formatter:'{value} m'
                  }
              },
              yAxis: {
                  type: 'value',
                  data:sou,
              },
              series: [
                 
                  {
                      name:'声音',
                      type:'line',
                      data:sou
                  },
                 
                  
              ]
          }
      };
      if(fflag==7)
      {
          var option = {
            title: {
            text: '盐度/声音'
               },
          tooltip: {
              trigger: 'axis'
          },
          
          grid: {
              left: '3%',
              right: '4%',
              bottom: '3%',
              containLabel: true
          },
          toolbox: {
            show:true,
              feature: {
                  saveAsImage: {},

              }
          },
              xAxis: {
                  type: 'category',
                  data: sal,
                  
                  axisLabel:{
                    formatter:'{value} 盐度'
                  }
              },
              yAxis: {
                  type: 'value',
                  data:sou,
              },
              series: [
                 
                  {
                      name:'声音',
                      type:'line',
                      data:sou
                  },
                 
                  
              ]
          }
      };


      // 使用刚指定的配置项和数据显示图表。
      this.myChart1.setOption(option);
    },
      },
      mounted() {
    
  },

    }
  
</script>
<style>
 .el-row {
    margin-bottom: 20px;
    
  }

.cardstyle{
  margin-left: 30px;
  margin-right: 30px;
  margin-bottom: 10px;
}
    
</style>
