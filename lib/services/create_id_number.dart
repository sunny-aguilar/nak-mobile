// Purpose: creates a NAK ID number
// Format: chapter founding year, chapter #, class #, line #
// try catch block to return default id 0000 0000 0000 0000

class GenerateID {
  GenerateID({required this.chapter, required this.className, required this.lineNumber});
  String chapter;
  String className;
  String lineNumber;

  final Map<String, String> _chapterYear = {
    'Founding': '1988',
    'Alpha': '1989',
    'Beta': '1990',
    'Gamma': '1992',
    'Delta': '1992',
    'Epsilon': '1992',
    'Zeta': '1992',
    'Eta': '1993',
    'Theta': '1995',
    'Iota': '1996',
    'Kappa': '1997',
    'Lambda': '1997',
    'Mu': '1999',
    'Nu': '2000',
    'Xi': '2004',
    'Omicron': '2004',
    'Pi': '2005',
    'Rho': '2005',
    'Sigma': '2007',
    'Tau': '2008',
    'Upsilon': '2009',
    'Phi': '2011',
    'Chi': '2012',
    'Psi': '2012',
    'Alpha Alpha': '2014',
    'Alpha Beta': '2014',
    'Alpha Gamma': '2017',
    'Alpha Delta': '2018',
  };

  final List<String> _chapterNumber = [
    'Founding','Alpha','Beta','Gamma','Delta','Epsilon','Zeta','Eta','Theta','Iota','Kappa','Lambda','Mu','Nu','Xi','Omicron','Pi','Rho','Sigma','Tau','Upsilon','Phi','Chi','Psi','Alpha Alpha','Alpha Beta','Alpha Gamma','Alpha Delta',
  ];

  final List<String> _classNumber = [
    'Founding','Alpha','Beta','Gamma','Delta','Epsilon','Zeta','Eta','Theta','Iota','Kappa','Lambda','Mu','Nu','Xi','Omicron','Pi','Rho','Sigma','Tau','Upsilon','Phi','Chi','Psi','Alpha Alpha','Alpha Beta','Alpha Gamma','Alpha Delta','Alpha Epsilon','Alpha Zeta','Alpha Eta','Alpha Theta','Alpha Iota','Alpha Kappa','Alpha Lambda','Alpha Mu','Alpha Nu','Alpha Xi','Alpha Omicon','Alpha Pi','Alpha Rho','Alpha Sigma','Alpha Tau','Alpha Upsilon','Alpha Phi','Alpha Chi','Alpha Psi','Beta Alpha','Beta Beta','Beta Gamma','Beta Delta','Beta Epsilon','Beta Zeta','Beta Eta','Beta Theta','Beta Iota','Beta Kappa','Beta Lambda','Beta Mu','Beta Nu','Beta Xi','Beta Omicron','Beta Pi','Beta Rho','Beta Sigma','Beta Tau','Beta Upsilon','Beta Phi','Beta Chi','Beta Psi',
  ];

  String generateID() {
    String id = '';
    id = _chapterYear[chapter] ?? ' 0000';
    id += _chapterNumber.contains(chapter) ? ' ${_chapterNumber.indexOf(chapter).toString().padLeft(4, '0')}' : ' 0000';
    id += _classNumber.contains(chapter) ? ' ${_classNumber.indexOf(className).toString().padLeft(4, '0')}' : ' 0000';
    id += ' ${lineNumber.padLeft(4, '0')}';
    return id;
  }
}








// chapter founding year, chapter #, class #, line #

