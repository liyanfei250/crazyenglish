class LiveUtil {
  static LiveStatus getLiveStatus(
      int startTime, int endTime, int actualEndTime, bool isSupportReplay,{int datumTime = 0}) {
    int tmpEndTime = 0;
    int nowTime;
    if(datumTime>0){
      nowTime = datumTime;
    }else{
      nowTime = DateTime.now().millisecondsSinceEpoch;
    }

    if (actualEndTime == 0) {
      // 升级前的缓存数据没有actualEndTime 所以可能为0
      tmpEndTime = endTime;
    } else {
      tmpEndTime = actualEndTime;
    }

    if (nowTime < startTime - 30 * 60 * 1000) {
      //未开始
      return LiveStatus.Not_Started;
    }
    // 直播中 当前时间 直播开始前30分钟-直播结束
    else if (startTime - 30 * 60 * 1000 <= nowTime && nowTime < tmpEndTime) {
      return LiveStatus.Live_Playing;
    } else {
      if (isSupportReplay) {
        if (nowTime > tmpEndTime && nowTime < tmpEndTime + 3 * 60 * 60 * 1000) {
          // 回放生成中
          if (actualEndTime > 0) {
            return LiveStatus.Playback_Generating; // 回放生成中
          } else {
            return LiveStatus.Live_Playing; // 还没有下课
          }
        } else {
          return LiveStatus.Live_Playback; // 回放已生成
        }
      } else {
        // 不支持回放 已结束 无回放
        if (actualEndTime > 0) {
          return LiveStatus.Live_Finished;
        } else {
          if (nowTime < tmpEndTime + 3 * 60 * 60 * 1000) {
            return LiveStatus.Live_Playing;
          } else {
            return LiveStatus.Live_Finished;
          }
        }
      }
    }
  }
}

enum LiveStatus {
  //未开始
  Not_Started,
  //直播中
  Live_Playing,
  //3 看回放
  Live_Playback,
  //4 已结束
  Live_Finished,
  //5 回放生成中
  Playback_Generating
}
