// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Registration {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  String chapterNumberID({required String chapter}) {
    String chapterNumber = '';
    switch (chapter) {
      case 'Founding':
        chapterNumber = '00.founding';
        break;
      case 'Alpha':
        chapterNumber = '01.alpha';
        break;
      case 'Beta':
        chapterNumber = '02.beta';
        break;
      case 'Gamma':
        chapterNumber = '03.gamma';
        break;
      case 'Delta':
        chapterNumber = '04.delta';
        break;
      case 'Epsilon':
        chapterNumber = '05.epsilon';
        break;
      case 'Zeta':
        chapterNumber = '06.zeta';
        break;
      case 'Eta':
        chapterNumber = '07.eta';
        break;
      case 'Theta':
        chapterNumber = '08.theta';
        break;
      case 'Iota':
        chapterNumber = '09.iota';
        break;
      case 'Kappa':
        chapterNumber = '10.kappa';
        break;
      case 'Lambda':
        chapterNumber = '11.lambda';
        break;
      case 'Mu':
        chapterNumber = '12.mu';
        break;
      case 'Nu':
        chapterNumber = '13.nu';
        break;
      case 'Xi':
        chapterNumber = '14.xi';
        break;
      case 'Omicron':
        chapterNumber = '15.omicron';
        break;
      case 'Pi':
        chapterNumber = '17.pi';
        break;
      case 'Rho':
        chapterNumber = '18.rho';
        break;
      case 'Sigma':
        chapterNumber = '19.sigma';
        break;
      case 'Tau':
        chapterNumber = '20.tau';
        break;
      case 'Upsilon':
        chapterNumber = '21.upsilon';
        break;
      case 'Phi':
        chapterNumber = '22.phi';
        break;
      case 'Chi':
        chapterNumber = '23.chi';
        break;
      case 'Psi':
        chapterNumber = '24.psi';
        break;
      case 'Alpha Alpha':
        chapterNumber = '25.aa';
        break;
      case 'Alpha Beta':
        chapterNumber = '26.ab';
        break;
      case 'Alpha Gamma':
        chapterNumber = '27.ag';
        break;
      case 'Alpha Delta':
        chapterNumber = '28.ad';
        break;
      default:
    }
    return chapterNumber;
  }
}