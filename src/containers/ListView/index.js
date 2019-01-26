import React, { Component } from 'react'
import { connect }            from 'react-redux'
import { bindActionCreators }       from 'redux'

import * as accountActionCreators from 'core/actions/actions-account'
import * as assetActionCreators   from 'core/actions/actions-asset'

/* component styles */
import { styles } from './styles.scss'
class ListView extends Component {
  constructor(props) {
    super(props)
  }

  componentWillUnmount() {
    const { actions } = this.props
    actions.account.clear()
    actions.asset.clear()
  }

  renderList() {
    return this.props.assets.map((file) => (
        <li key={file.FileHash} className='list-group-item'>{file.FileHash}</li>
    ));
  }



  render() {
    return (
      <ul className='list-group col-sm-4'>
            {this.renderList()}
      </ul>
    );
  }
}

function mapStateToProps(state) {
   return {
     assets: state.asset.assets     
   }
 }

 function mapDispatchToProps(dispatch) {
  return {
    actions: {
      account: bindActionCreators(accountActionCreators, dispatch),
      asset: bindActionCreators(assetActionCreators, dispatch)
    }
  }
}

 
export default connect(mapStateToProps, mapDispatchToProps)(ListView)

