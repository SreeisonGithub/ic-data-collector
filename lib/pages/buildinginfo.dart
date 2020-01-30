import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kapp/pages/fourlimit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './detailnumberarea.dart';
import './typepropertyuser.dart';

class BuildingInfoPage extends StatefulWidget {
  BuildingInfoPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _BuildingInfoPageState createState() => _BuildingInfoPageState();
}

class _BuildingInfoPageState extends State<BuildingInfoPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  FocusNode _fst_specifyif_other;
  FocusNode _fst_no_of_floors;
  FocusNode _fst_cubie_meter;
  FocusNode _snd_specifyif_other;
  FocusNode _snd_no_of_floors;
  FocusNode _snd_cubie_meter;
  FocusNode _trd_specifyif_other;
  FocusNode _trd_no_of_floors;
  FocusNode _trd_cubie_meter;
  FocusNode _forth_specifyif_other;
  FocusNode _forth_no_of_floors;
  FocusNode _forth_cubie_meter;
  FocusNode _fth_specifyif_other;
  FocusNode _fth_no_of_floors;
  FocusNode _fth_cubie_meter;
  Future<String> appimagepicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var apppath = await getApplicationDocumentsDirectory();
    var filename = image.path.split("/").last;
    var localfile = await image.copy('${apppath.path}/$filename');
    return localfile.path;
  }

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  Widget formheader({String headerlablekey}) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(177, 201, 224, 1),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            setapptext(key: headerlablekey),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget nextbutton() {
    return GestureDetector(
      onTap: () async {
        if (!(_formkey.currentState.validate())) {
          return;
        } else {
          _formkey.currentState.save();
          await DBHelper()
              .updatePropertySurvey(localdata, localdata.local_property_key);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => DetailsNumberAreaPage(
                localdata: localdata,
              ),
            ),
          );
        }
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              setapptext(key: 'key_next'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  Widget backbutton() {
    return GestureDetector(
      onTap: () {
        if (localdata.current_use_of_property == "6") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => FourLimitPage(
                localdata: localdata,
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TypePropertyUserPage(
                localdata: localdata,
              ),
            ),
          );
        }
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Icon(Icons.arrow_back_ios),
            Text(
              setapptext(key: 'key_back'),
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    localdata = new LocalPropertySurvey();
    localdata = widget.localdata;
    super.initState();
    _fst_specifyif_other = new FocusNode();
    _fst_no_of_floors = new FocusNode();
    _fst_cubie_meter = new FocusNode();
    _snd_specifyif_other = new FocusNode();
    _snd_no_of_floors = new FocusNode();
    _snd_cubie_meter = new FocusNode();
    _trd_specifyif_other = new FocusNode();
    _trd_no_of_floors = new FocusNode();
    _trd_cubie_meter = new FocusNode();
    _forth_specifyif_other = new FocusNode();
    _forth_no_of_floors = new FocusNode();
    _forth_cubie_meter = new FocusNode();
    _fth_specifyif_other = new FocusNode();
    _fth_no_of_floors = new FocusNode();
    _fth_cubie_meter = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_property_survey'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<DBHelper>(
        builder: (context, dbdata, child) {
          return dbdata.state == AppState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //header
                        formheader(headerlablekey: 'key_building_info'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formCardDropdown(
                                  value: localdata.fst_have_building?.isEmpty ??
                                          true
                                      ? "0"
                                      : localdata.fst_have_building,
                                  iscompleted: ((localdata
                                                  .fst_have_building?.isEmpty ??
                                              true) ||
                                          (localdata.fst_have_building == "0"))
                                      ? false
                                      : true,
                                  headerlablekey: setapptext(
                                      key: 'key_does_property_building'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_yes_sir'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_no'),
                                        value: "2")
                                  ],
                                  onSaved: (String value) {
                                    localdata.fst_have_building = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fst_have_building = value;
                                    setState(() {
                                      localdata.fst_have_building = null;
                                      localdata.fst_building_category = null;
                                      localdata.fst_specifyif_other = null;
                                      localdata.fst_no_of_floors = null;
                                      localdata.fst_cubie_meter = null;
                                      localdata.snd_have_building = null;
                                      localdata.snd_building_use = null;
                                      localdata.snd_building_category = null;
                                      localdata.snd_no_of_floors = null;
                                      localdata.snd_cubie_meter = null;
                                      localdata.trd_have_building = null;
                                      localdata.snd_building_category = null;
                                      localdata.snd_specifyif_other = null;
                                      localdata.snd_no_of_floors = null;
                                      localdata.snd_cubie_meter = null;
                                      localdata.trd_have_building = null;
                                      localdata.trd_building_use = null;
                                      localdata.trd_building_category = null;
                                      localdata.trd_specifyif_other = null;
                                      localdata.trd_no_of_floors = null;
                                      localdata.trd_cubie_meter = null;
                                      localdata.forth_have_building = null;
                                      localdata.forth_building_use = null;
                                      localdata.forth_building_category = null;
                                      localdata.forth_specifyif_other = null;
                                      localdata.forth_no_of_floors = null;
                                      localdata.forth_cubie_meter = null;
                                      localdata.fth_have_building = null;
                                      localdata.fth_building_use = null;
                                      localdata.fth_building_category = null;
                                      localdata.fth_specifyif_other = null;
                                      localdata.fth_no_of_floors = null;
                                      localdata.fth_cubie_meter = null;
                                    });
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return setapptext(key: 'key_required');
                                    }
                                  }),

                              ///first building
                              ///start
                              if (localdata.fst_have_building == "1") ...[
                                formCardDropdown(
                                    iscompleted: ((localdata.fst_building_use
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.fst_building_use == "0"))
                                        ? false
                                        : true,
                                    headerlablekey:
                                        setapptext(key: 'key_building_use'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_release'),
                                          value: "1"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_commercial'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_govt'),
                                          value: "3"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_productive'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_general'),
                                          value: "5"),
                                    ],
                                    onChanged: (value) {
                                      localdata.fst_building_use = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.fst_building_use = value;
                                    },
                                    value:
                                        localdata.fst_building_use?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.fst_building_use,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formCardDropdown(
                                    iscompleted: ((localdata
                                                    .fst_building_category
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.fst_building_category ==
                                                "0"))
                                        ? false
                                        : true,
                                    headerlablekey: setapptext(
                                        key: 'key_building_category'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Modern_Concrete'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Concrete'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Half_cream_and_half_baked'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Cream'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_metal'),
                                          value: "5"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Another'),
                                          value: "6"),
                                    ],
                                    onChanged: (value) {
                                      localdata.fst_building_category = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.fst_building_category = value;
                                    },
                                    value: localdata.fst_building_category
                                                ?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.fst_building_category,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formcardtextfield(
                                    initvalue: localdata
                                                .fst_specifyif_other?.isEmpty ??
                                            true
                                        ? ""
                                        : localdata.fst_specifyif_other,
                                    headerlablekey:
                                        setapptext(key: 'key_choose_another'),
                                    fieldfocus: _fst_specifyif_other,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      _fst_specifyif_other.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_fst_no_of_floors);
                                    },
                                    hinttextkey: '',
                                    radiovalue: localdata
                                                .fst_specifyif_other?.isEmpty ??
                                            true
                                        ? false
                                        : true,
                                    onSaved: (value) {
                                      localdata.fst_specifyif_other =
                                          value.trim();
                                    },
                                    onChanged: (value) {
                                      localdata.fst_specifyif_other =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.fst_no_of_floors?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.fst_no_of_floors,
                                    headerlablekey:
                                        setapptext(key: 'key_Number_of_floors'),
                                    fieldfocus: _fst_no_of_floors,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      _fst_no_of_floors.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_fst_cubie_meter);
                                    },
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.fst_no_of_floors?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.fst_no_of_floors = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.fst_no_of_floors = value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.fst_cubie_meter?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.fst_cubie_meter,
                                    headerlablekey:
                                        setapptext(key: 'key_Unit_Size'),
                                    fieldfocus: _fst_cubie_meter,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) {
                                      _fst_cubie_meter.unfocus();
                                    },
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.fst_cubie_meter?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.fst_cubie_meter = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.fst_cubie_meter = value.trim();
                                      setState(() {});
                                    }),
                                formCardDropdown(
                                    value:
                                        localdata.snd_have_building?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.snd_have_building,
                                    iscompleted: ((localdata.snd_have_building
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.snd_have_building ==
                                                "0"))
                                        ? false
                                        : true,
                                    headerlablekey:
                                        setapptext(key: 'key_add_building'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_yes_sir'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_no'),
                                          value: "2")
                                    ],
                                    onSaved: (String value) {
                                      localdata.snd_have_building = value;
                                    },
                                    onChanged: (value) {
                                      localdata.snd_have_building = value;
                                      setState(() {
                                        localdata.snd_building_use = null;
                                        localdata.snd_building_category = null;
                                        localdata.snd_no_of_floors = null;
                                        localdata.snd_cubie_meter = null;
                                        localdata.trd_have_building = null;
                                        localdata.snd_building_category = null;
                                        localdata.snd_specifyif_other = null;
                                        localdata.snd_no_of_floors = null;
                                        localdata.snd_cubie_meter = null;
                                        localdata.trd_have_building = null;
                                        localdata.trd_building_use = null;
                                        localdata.trd_building_category = null;
                                        localdata.trd_specifyif_other = null;
                                        localdata.trd_no_of_floors = null;
                                        localdata.trd_cubie_meter = null;
                                        localdata.forth_have_building = null;
                                        localdata.forth_building_use = null;
                                        localdata.forth_building_category =
                                            null;
                                        localdata.forth_specifyif_other = null;
                                        localdata.forth_no_of_floors = null;
                                        localdata.forth_cubie_meter = null;
                                        localdata.fth_have_building = null;
                                        localdata.fth_building_use = null;
                                        localdata.fth_building_category = null;
                                        localdata.fth_specifyif_other = null;
                                        localdata.fth_no_of_floors = null;
                                        localdata.fth_cubie_meter = null;
                                      });
                                    },
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                              ],

                              ///end
                              ///second building
                              ///start
                              if (localdata.snd_have_building == "1") ...[
                                formCardDropdown(
                                    iscompleted: ((localdata.snd_building_use
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.snd_building_use == "0"))
                                        ? false
                                        : true,
                                    headerlablekey:
                                        setapptext(key: 'key_building_use'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_release'),
                                          value: "1"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_commercial'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_govt'),
                                          value: "3"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_productive'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_general'),
                                          value: "5"),
                                    ],
                                    onChanged: (value) {
                                      localdata.snd_building_use = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.snd_building_use = value;
                                    },
                                    value:
                                        localdata.snd_building_use?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.snd_building_use,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formCardDropdown(
                                    iscompleted: ((localdata
                                                    .snd_building_category
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.snd_building_category ==
                                                "0"))
                                        ? false
                                        : true,
                                    headerlablekey: setapptext(
                                        key: 'key_building_category'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Modern_Concrete'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Concrete'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Half_cream_and_half_baked'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Cream'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_metal'),
                                          value: "5"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Another'),
                                          value: "6"),
                                    ],
                                    onChanged: (value) {
                                      localdata.snd_building_category = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.snd_building_category = value;
                                    },
                                    value: localdata.snd_building_category
                                                ?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.snd_building_category,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formcardtextfield(
                                    initvalue: localdata
                                                .snd_specifyif_other?.isEmpty ??
                                            true
                                        ? ""
                                        : localdata.snd_specifyif_other,
                                    headerlablekey:
                                        setapptext(key: 'key_choose_another'),
                                    fieldfocus: _snd_specifyif_other,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      _snd_specifyif_other.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_snd_no_of_floors);
                                    },
                                    hinttextkey: '',
                                    radiovalue: localdata
                                                .snd_specifyif_other?.isEmpty ??
                                            true
                                        ? false
                                        : true,
                                    onSaved: (value) {
                                      localdata.snd_specifyif_other =
                                          value.trim();
                                    },
                                    onChanged: (value) {
                                      localdata.snd_specifyif_other =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.snd_no_of_floors?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.snd_no_of_floors,
                                    headerlablekey:
                                        setapptext(key: 'key_Number_of_floors'),
                                    fieldfocus: _snd_no_of_floors,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      _snd_no_of_floors.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_snd_cubie_meter);
                                    },
                                    radiovalue:
                                        localdata.snd_no_of_floors?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.snd_no_of_floors = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.snd_no_of_floors = value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.snd_cubie_meter?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.snd_cubie_meter,
                                    headerlablekey:
                                        setapptext(key: 'key_Unit_Size'),
                                    fieldfocus: _snd_cubie_meter,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) {
                                      _snd_cubie_meter.unfocus();
                                    },
                                    radiovalue:
                                        localdata.snd_cubie_meter?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.snd_cubie_meter = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.snd_cubie_meter = value.trim();
                                      setState(() {});
                                    }),
                                formCardDropdown(
                                    value:
                                        localdata.trd_have_building?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.trd_have_building,
                                    iscompleted: ((localdata.trd_have_building
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.trd_have_building ==
                                                "0"))
                                        ? false
                                        : true,
                                    headerlablekey:
                                        setapptext(key: 'key_add_building'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_yes_sir'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_no'),
                                          value: "2")
                                    ],
                                    onSaved: (String value) {
                                      localdata.trd_have_building = value;
                                    },
                                    onChanged: (value) {
                                      localdata.trd_have_building = value;
                                      setState(() {
                                        localdata.snd_building_category = null;
                                        localdata.snd_specifyif_other = null;
                                        localdata.snd_no_of_floors = null;
                                        localdata.snd_cubie_meter = null;
                                        localdata.trd_have_building = null;
                                        localdata.trd_building_use = null;
                                        localdata.trd_building_category = null;
                                        localdata.trd_specifyif_other = null;
                                        localdata.trd_no_of_floors = null;
                                        localdata.trd_cubie_meter = null;
                                        localdata.forth_have_building = null;
                                        localdata.forth_building_use = null;
                                        localdata.forth_building_category =
                                            null;
                                        localdata.forth_specifyif_other = null;
                                        localdata.forth_no_of_floors = null;
                                        localdata.forth_cubie_meter = null;
                                        localdata.fth_have_building = null;
                                        localdata.fth_building_use = null;
                                        localdata.fth_building_category = null;
                                        localdata.fth_specifyif_other = null;
                                        localdata.fth_no_of_floors = null;
                                        localdata.fth_cubie_meter = null;
                                      });
                                    },
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                              ],

                              ///end
                              ///third building
                              ///start
                              if (localdata.trd_have_building == "1") ...[
                                formCardDropdown(
                                    iscompleted: ((localdata.trd_building_use
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.trd_building_use == "0"))
                                        ? false
                                        : true,
                                    headerlablekey:
                                        setapptext(key: 'key_building_use'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_release'),
                                          value: "1"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_commercial'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_govt'),
                                          value: "3"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_productive'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_general'),
                                          value: "5"),
                                    ],
                                    onChanged: (value) {
                                      localdata.trd_building_use = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.trd_building_use = value;
                                    },
                                    value:
                                        localdata.trd_building_use?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.trd_building_use,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formCardDropdown(
                                    iscompleted: ((localdata
                                                    .trd_building_category
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.trd_building_category ==
                                                "0"))
                                        ? false
                                        : true,
                                    headerlablekey: setapptext(
                                        key: 'key_building_category'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Modern_Concrete'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Concrete'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Half_cream_and_half_baked'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Cream'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_metal'),
                                          value: "5"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Another'),
                                          value: "6"),
                                    ],
                                    onChanged: (value) {
                                      localdata.trd_building_category = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.trd_building_category = value;
                                    },
                                    value: localdata.trd_building_category
                                                ?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.trd_building_category,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formcardtextfield(
                                    initvalue: localdata
                                                .trd_specifyif_other?.isEmpty ??
                                            true
                                        ? ""
                                        : localdata.trd_specifyif_other,
                                    headerlablekey:
                                        setapptext(key: 'key_choose_another'),
                                    fieldfocus: _trd_specifyif_other,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      _trd_specifyif_other.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_trd_no_of_floors);
                                    },
                                    hinttextkey: '',
                                    radiovalue: localdata
                                                .trd_specifyif_other?.isEmpty ??
                                            true
                                        ? false
                                        : true,
                                    onSaved: (value) {
                                      localdata.trd_specifyif_other =
                                          value.trim();
                                    },
                                    onChanged: (value) {
                                      localdata.trd_specifyif_other =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.trd_no_of_floors?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.trd_no_of_floors,
                                    headerlablekey:
                                        setapptext(key: 'key_Number_of_floors'),
                                    fieldfocus: _trd_no_of_floors,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      _trd_no_of_floors.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_trd_cubie_meter);
                                    },
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.trd_no_of_floors?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.trd_no_of_floors = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.trd_no_of_floors = value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.trd_cubie_meter?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.trd_cubie_meter,
                                    headerlablekey:
                                        setapptext(key: 'key_Unit_Size'),
                                    fieldfocus: _trd_cubie_meter,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) {
                                      _trd_cubie_meter.unfocus();
                                    },
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.trd_cubie_meter?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.trd_cubie_meter = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.trd_cubie_meter = value.trim();
                                      setState(() {});
                                    }),
                                formCardDropdown(
                                    value: localdata
                                                .forth_have_building?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.forth_have_building,
                                    iscompleted: ((localdata.forth_have_building
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.forth_have_building ==
                                                "0"))
                                        ? false
                                        : true,
                                    headerlablekey:
                                        setapptext(key: 'key_add_building'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_yes_sir'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_no'),
                                          value: "2")
                                    ],
                                    onSaved: (String value) {
                                      localdata.forth_have_building = value;
                                    },
                                    onChanged: (value) {
                                      localdata.forth_have_building = value;
                                      setState(() {
                                        localdata.forth_building_use = null;
                                        localdata.forth_building_category =
                                            null;
                                        localdata.forth_specifyif_other = null;
                                        localdata.forth_no_of_floors = null;
                                        localdata.forth_cubie_meter = null;
                                        localdata.fth_have_building = null;
                                        localdata.fth_building_use = null;
                                        localdata.fth_building_category = null;
                                        localdata.fth_specifyif_other = null;
                                        localdata.fth_no_of_floors = null;
                                        localdata.fth_cubie_meter = null;
                                      });
                                    },
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                              ],

                              ///end

                              ///forth building
                              ///start
                              if (localdata.forth_have_building == "1") ...[
                                formCardDropdown(
                                    iscompleted: ((localdata.forth_building_use
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.forth_building_use ==
                                                "0"))
                                        ? false
                                        : true,
                                    headerlablekey:
                                        setapptext(key: 'key_building_use'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_release'),
                                          value: "1"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_commercial'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_govt'),
                                          value: "3"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_productive'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_general'),
                                          value: "5"),
                                    ],
                                    onChanged: (value) {
                                      localdata.forth_building_use = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.forth_building_use = value;
                                    },
                                    value:
                                        localdata.forth_building_use?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.forth_building_use,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formCardDropdown(
                                    iscompleted: ((localdata
                                                    .forth_building_category
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata
                                                    .forth_building_category ==
                                                "0"))
                                        ? false
                                        : true,
                                    headerlablekey: setapptext(
                                        key: 'key_building_category'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Modern_Concrete'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Concrete'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Half_cream_and_half_baked'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Cream'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_metal'),
                                          value: "5"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Another'),
                                          value: "6"),
                                    ],
                                    onChanged: (value) {
                                      localdata.forth_building_category = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.forth_building_category = value;
                                    },
                                    value: localdata.forth_building_category
                                                ?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.forth_building_category,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formcardtextfield(
                                    initvalue: localdata.forth_specifyif_other
                                                ?.isEmpty ??
                                            true
                                        ? ""
                                        : localdata.forth_specifyif_other,
                                    headerlablekey:
                                        setapptext(key: 'key_choose_another'),
                                    fieldfocus: _forth_specifyif_other,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      _forth_specifyif_other.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_forth_no_of_floors);
                                    },
                                    hinttextkey: '',
                                    radiovalue: localdata.forth_specifyif_other
                                                ?.isEmpty ??
                                            true
                                        ? false
                                        : true,
                                    onSaved: (value) {
                                      localdata.forth_specifyif_other =
                                          value.trim();
                                    },
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.forth_specifyif_other =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.forth_no_of_floors?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.forth_no_of_floors,
                                    headerlablekey:
                                        setapptext(key: 'key_Number_of_floors'),
                                    fieldfocus: _forth_no_of_floors,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      _forth_no_of_floors.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_forth_cubie_meter);
                                    },
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.forth_no_of_floors?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.forth_no_of_floors =
                                          value.trim();
                                    },
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.forth_no_of_floors =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.forth_cubie_meter?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.forth_cubie_meter,
                                    headerlablekey:
                                        setapptext(key: 'key_Unit_Size'),
                                    fieldfocus: _forth_cubie_meter,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) {
                                      _forth_cubie_meter.unfocus();
                                    },
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.forth_cubie_meter?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.forth_cubie_meter =
                                          value.trim();
                                    },
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.forth_cubie_meter =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formCardDropdown(
                                    value:
                                        localdata.fth_have_building?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.fth_have_building,
                                    iscompleted: ((localdata.fth_have_building
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.fth_have_building ==
                                                "0"))
                                        ? false
                                        : true,
                                    headerlablekey:
                                        setapptext(key: 'key_add_building'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_yes_sir'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_no'),
                                          value: "2")
                                    ],
                                    onSaved: (String value) {
                                      localdata.fth_have_building = value;
                                    },
                                    onChanged: (value) {
                                      localdata.fth_have_building = value;
                                      setState(() {
                                        localdata.fth_building_use = null;
                                        localdata.fth_building_category = null;
                                        localdata.fth_specifyif_other = null;
                                        localdata.fth_no_of_floors = null;
                                        localdata.fth_cubie_meter = null;
                                      });
                                    },
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                              ],

                              ///end

                              ///fifth building
                              ///start
                              if (localdata.fth_have_building == "1") ...[
                                formCardDropdown(
                                    iscompleted: ((localdata.fth_building_use
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.fth_building_use == "0"))
                                        ? false
                                        : true,
                                    headerlablekey:
                                        setapptext(key: 'key_building_use'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_release'),
                                          value: "1"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_commercial'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_govt'),
                                          value: "3"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_productive'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_general'),
                                          value: "5"),
                                    ],
                                    onChanged: (value) {
                                      localdata.fth_building_use = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.fth_building_use = value;
                                    },
                                    value:
                                        localdata.fth_building_use?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.fth_building_use,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formCardDropdown(
                                    iscompleted: ((localdata
                                                    .fth_building_category
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.fth_building_category ==
                                                "0"))
                                        ? false
                                        : true,
                                    headerlablekey: setapptext(
                                        key: 'key_building_category'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Modern_Concrete'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Concrete'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Half_cream_and_half_baked'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Cream'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_metal'),
                                          value: "5"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Another'),
                                          value: "6"),
                                    ],
                                    onChanged: (value) {
                                      localdata.fth_building_category = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.fth_building_category = value;
                                    },
                                    value: localdata.fth_building_category
                                                ?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.fth_building_category,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formcardtextfield(
                                    initvalue: localdata
                                                .fth_specifyif_other?.isEmpty ??
                                            true
                                        ? ""
                                        : localdata.fth_specifyif_other,
                                    headerlablekey:
                                        setapptext(key: 'key_choose_another'),
                                    fieldfocus: _fth_specifyif_other,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      _fth_specifyif_other.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_fth_no_of_floors);
                                    },
                                    hinttextkey: '',
                                    radiovalue: localdata
                                                .fth_specifyif_other?.isEmpty ??
                                            true
                                        ? false
                                        : true,
                                    onSaved: (value) {
                                      localdata.fth_specifyif_other =
                                          value.trim();
                                    },
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.fth_specifyif_other =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.fth_no_of_floors?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.fth_no_of_floors,
                                    headerlablekey:
                                        setapptext(key: 'key_Number_of_floors'),
                                    fieldfocus: _fth_no_of_floors,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      _fth_no_of_floors.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_fth_cubie_meter);
                                    },
                                    radiovalue:
                                        localdata.fth_no_of_floors?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.fth_no_of_floors = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.fth_no_of_floors = value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.fth_cubie_meter?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.fth_cubie_meter,
                                    headerlablekey:
                                        setapptext(key: 'key_Unit_Size'),
                                    fieldfocus: _fth_cubie_meter,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) {
                                      _fth_cubie_meter.unfocus();
                                    },
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.fth_cubie_meter?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.fth_cubie_meter = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.fth_cubie_meter = value.trim();
                                      setState(() {});
                                    })
                              ],

                              ///end
                            ],
                          ),
                        ),
                        //footer
                        Container(
                          child: Column(
                            children: <Widget>[
                              Divider(
                                color: Colors.blueAccent,
                              ),
                              Container(
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      backbutton(),
                                      nextbutton()
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
