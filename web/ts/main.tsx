
import * as React from "react";
import { observer } from "mobx-react";
import { observable, action } from "mobx";

interface MainProps {}

interface FormState {}

@observer
export class Main extends React.Component<MainProps, FormState> {
  constructor(props: MainProps) {
    super(props);
  }
  render() {
    return <div><p>Hello Clone.</p></div>
  }
}
