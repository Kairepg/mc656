import 'package:flutter/material.dart';
import 'package:fitness_buddy/pages/terms/terms_conditions_view.dart';



class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            const Header(
                title:"Termos e condições",
                subtitle: "Leia nossos termos e condições de uso"),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: 
                
                     Text(
                       "	Lorem ipsum donec nam metus volutpat primis fusce ut enim volutpat aptent cubilia sollicitudin magna taciti, litora ultricies at luctus fames auctor suscipit conubia bibendum sollicitudin vehicula tortor curae. est taciti dui sem interdum class luctus adipiscing ac nunc aptent eleifend suscipit class faucibus sagittis, sollicitudin ut quis primis vel ligula fermentum quisque ultrices hac tempus at enim vel. erat ad quisque lobortis sem sit cras a purus nec praesent dui, enim facilisis in ipsum ut scelerisque lectus primis faucibus. volutpat curabitur phasellus eget a malesuada pharetra tincidunt praesent, aliquam aptent ante scelerisque quisque ad sagittis etiam gravida, curabitur elementum ultrices velit purus vivamus vel."

	"Class donec ut nisi cras imperdiet quisque, lectus consequat senectus augue. dictumst aliquam eleifend est placerat dolor, ornare turpis est rutrum quisque, faucibus sollicitudin turpis curabitur. massa et conubia consequat litora tellus feugiat egestas tempor etiam adipiscing volutpat condimentum, enim eu quis id enim elementum convallis vivamus accumsan pellentesque. viverra aliquet id nec fusce mattis quis nunc ut non, justo ac in integer torquent quis ut class habitant sapien, praesent ullamcorper malesuada tempor sit nisl class posuere. ante conubia eu interdum in primis vivamus augue, odio habitasse platea lobortis curae semper, augue netus ullamcorper dui ornare non. "

	"Arcu commodo in donec habitant conubia vel suscipit curae lectus ut, et praesent nam vulputate erat taciti per ante orci nibh, mauris quisque bibendum hac tempus lorem quis mi aptent. aliquet fermentum lobortis eu sapien nunc mauris, a dictumst aptent nullam enim, scelerisque habitant dictumst pellentesque ornare. velit aliquam cubilia nulla nostra faucibus tortor class, venenatis congue senectus blandit porta curabitur habitasse vitae, quam lacinia torquent aliquam lorem orci. porttitor iaculis ipsum lobortis ultricies ut malesuada porttitor, ligula a ante mi conubia blandit, arcu imperdiet suspendisse vivamus donec dictum. posuere elementum pharetra curabitur diam turpis, tristique curabitur posuere. ",
                    )
                    
              ),
            
          ],
        )
      ),
    );
  }
}




  // @override
  // Widget build(BuildContext context) {

  //   return Scaffold(
  //     body: Column(
  //       children: [
  //         Row(
  //           children: [
  //             GestureDetector(
  //               onTap: (){
  //                 Get.back();
  //               }
  //             )
  //           ],

  //         )
  //       ],
  //     ),
  //   )
    
  // }

