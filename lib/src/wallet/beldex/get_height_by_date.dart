import 'package:intl/intl.dart';

final dateFormat = DateFormat('yyyy-MM');
final dates = {
  '2019-03': 21165,
  '2019-04': 42676,
  '2019-05': 64919,
  '2019-06': 87176,
  '2019-07': 108688,
  '2019-08': 130936,
  '2019-09': 152453,
  '2019-10': 174681,
  '2019-11': 196907,
  '2019-12': 217018,
  '2020-01': 239354,
  '2020-02': 260947,
  '2020-03': 283215,
  '2020-04': 304759,
  '2020-05': 326680,
  '2020-06': 348927,
  '2020-07': 370534,
  '2020-08': 392808,
  '2020-09': 414271,
  '2020-10': 436563,
  '2020-11': 458818,
  '2020-12': 479655,
  '2021-01': 501871,
  '2021-02': 523357,
  '2021-03': 545570,
  '2021-04': 567124,
  '2021-05': 589403,
  '2021-06': 611688,
  '2021-07': 633162,
  '2021-08': 655439,
  '2021-09': 677039,
  '2021-10': 699359,
  '2021-11': 721679,
  '2021-12': 741839,
  '2022-01': 790000,

     '2022-02' : 877781,
        '2022-0' :958421,
        '2022-04': 1006790,
        '2022-05' : 1093190,
       '2022-06': 1199750,
        '2022-07' : 1291910,
        '2022-08' : 1361030,
        '2022-09': 1456070,
        '2022-10':1575070,

        '2022-11':1674950,
        '2022-12': 1764950,
       '2023-02':1942950,
        '2023-03' : 2022950,
        '2023-04':2112950,
        '2023-05': 2199950,
        '2023-06':2289269,
        '2023-07': 2363143
  
};


// final dates_testnet = {
//   '2022-11' :1,
//   '2022-12':212260, 
//   '2023-01' : 302660,
//   '2023-02': 391660,
//   '2023-03' :498660,
//   '2023-04': ,
// };


int getHeightByDate({required DateTime date}) {
  final raw = '${date.year}-${date.month < 10 ? '0${date.month}' : date.month}';
  final firstDate = dateFormat.parse(dates.keys.first);
  var height = dates[raw] ?? 0;

  if (height <= 0 && date.isAfter(firstDate)) {
    height = dates.values.last;
  }

  return height;
}


// int getBlockHeight({DateTime date}){
//    const PIVOT_BLOCK_HEIGHT = 742421;
//     const PIVOT_BLOCK_TIMESTAMP = 1639187815;
//     const PIVOT_BLOCK_TIME = 0;

//     var timeStamp = date.
// }







// timestampToHeight(date: any) {
//     const PIVOT_BLOCK_HEIGHT = 742421;
//     const PIVOT_BLOCK_TIMESTAMP = 1639187815;
//     const PIVOT_BLOCK_TIME = 0;
//     return new Promise((resolve, reject) => {

//       let timestamp = new Date(date).getTime();
//       timestamp = timestamp - (timestamp % 86400000) - 86400000;

//       if (timestamp > 999999999999) {
//         // We have got a JS ms timestamp, convert
//         timestamp = Math.floor(timestamp / 1000);
//       }
//       if (timestamp > 1639187815) {
//        PIVOT_BLOCK_TIME = 30;
//       } else {
//        PIVOT_BLOCK_TIME = 120;
//       }
//       const pivot = [PIVOT_BLOCK_HEIGHT,PIVOT_BLOCK_TIMESTAMP];
//       let diff = Math.floor((timestamp - pivot[1]) /PIVOT_BLOCK_TIME);
//       let estimated_height = pivot[0] + diff;

//       if (estimated_height <= 0) {
//         return resolve(0);
//       }
//       this.sendRPC('getblockheaderbyheight', {
//         height: estimated_height,
//       }).then(data => {
//         if (data.hasOwnProperty('error') || !data.hasOwnProperty('result')) {
//           if (data.error.code == -2) {
//             // Too big height
//             this.sendRPC('getlastblockheader').then(data => {
//               if (data.hasOwnProperty('error') || !data.hasOwnProperty('result')) {
//                 return reject();
//               }
//               let new_pivot = [data.result.block_header.height, data.result.block_header.timestamp];
//               // If we are within an hour that is good enough
//               // If for some reason there is a > 1h gap between blocks
//               // the recursion limit will take care of infinite loop
//               if (Math.abs(timestamp - new_pivot[1]) < 3600) {
//                 return resolve(new_pivot[0]);
//               }

//               // Continue recursion with new pivot
//               resolve(new_pivot[0]);
//             });
//             return;
//           } else {
//             return reject();
//           }
//         }

//         let new_pivot = [data.result.block_header.height, data.result.block_header.timestamp];

//         // If we are within an hour that is good enough
//         // If for some reason there is a > 1h gap between blocks
//         // the recursion limit will take care of infinite loop
//         if (Math.abs(timestamp - new_pivot[1]) < 3600) {
//           return resolve(new_pivot[0]);
//         }
//         // Continue recursion with new pivot
//         resolve(new_pivot[0]);
//       });
//     });
//   }
// }
